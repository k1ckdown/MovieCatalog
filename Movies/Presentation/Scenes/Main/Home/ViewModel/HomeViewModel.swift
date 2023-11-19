//
//  HomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class HomeViewModel: ViewModel {

    @Published private(set) var state: HomeViewState

    private let coordinator: HomeCoordinatorProtocol
    private let fetchMovieListUseCase: FetchMovieListUseCase
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase

    init(
        coordinator: HomeCoordinatorProtocol,
        fetchMovieListUseCase: FetchMovieListUseCase,
        getMovieDetailsUseCase: GetMovieDetailsUseCase
    ) {
        state = .idle
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func handle(_ event: HomeViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveMovies() }

        case .willDisplayLastMovie:
            Task { await loadMore() }

        case .onSelectMovie(let id):
            coordinator.showMovieDetails(id)
        }
    }
}

private extension HomeViewModel {

    func fetchMovies(page: Page?) async throws -> [MovieDetails] {
        let movies = try await fetchMovieListUseCase.execute(page: page)
        return try await getMovieDetailsUseCase.execute(movies)
    }

    func loadMore() async {
        do {
            let movies = try await fetchMovies(page: .next)
            let itemViewModels = makeItemViewModels(movies)
            state = state.loadedMore(itemViewModels)
        } catch let error as MovieRepositoryImplementation.MovieRepositoryError {
            state = error == .maxPagesReached ? state.unavailableLoadMore() : state.failedLoadMore()
        } catch {
            state = state.failedLoadMore()
        }
    }

    func retrieveMovies() async {
        var page: Page?
        if case .idle = state {
            state = .loading
            page = .first
        }

        do {
            let movies = try await fetchMovies(page: page)
            state = .loaded(getViewData(movies))
        } catch {
            state = .error("\(error.localizedDescription)")
        }
    }
}

// MARK: - View data

private extension HomeViewModel {

    func getViewData(_ movies: [MovieDetails]) -> HomeViewState.ViewData {
        let itemViewModels = makeItemViewModels(movies)
        let numberOfCards = 4
        return .init(
            loadMore: .available,
            cardItems: Array(itemViewModels[0..<numberOfCards]),
            listItems: Array(itemViewModels[numberOfCards...])
        )
    }

    func makeItemViewModels(_ movies: [MovieDetails]) -> [MovieDetailsItemViewModel] {
        movies.map { movie in
            MovieDetailsItemViewModel(
                id: movie.id,
                name: movie.name,
                year: movie.year,
                country: movie.country,
                poster: movie.poster,
                rating: movie.rating,
                userRating: movie.userRating,
                genres: movie.genres
            )
        }
    }
}
