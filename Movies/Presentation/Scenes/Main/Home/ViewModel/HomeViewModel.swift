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

    init(coordinator: HomeCoordinatorProtocol, fetchMovieListUseCase: FetchMovieListUseCase) {
        self.state = .idle
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
    }

    func handle(_ event: HomeViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .willDisplayLastMovie:
            Task { await loadMore() }

        case .onSelectMovie(let id):
            coordinator.showMovieDetails(id)
        }
    }
}

private extension HomeViewModel {

    func loadMore() async {
        do {
            let movies = try await fetchMovieListUseCase.execute(page: .next)
            let itemViewModels = makeItemViewModels(movies)
            state = state.loadedMore(itemViewModels)
        } catch let error as MovieRepository.MovieRepositoryError {
            state = error == .maxPagesReached ? state.unavailableLoadMore() : state.failedLoadMore()
        } catch {
            state = state.failedLoadMore()
        }
    }

    func fetchMovies() async {
        var page: Page?
        if case .idle = state {
            state = .loading
            page = .first
        }

        do {
            let movies = try await fetchMovieListUseCase.execute(page: page)
            let itemViewModels = makeItemViewModels(movies)
            state = .loaded(.init(loadMore: .available, movieItems: itemViewModels))
        } catch {
            state = .error("\(error)")
        }
    }
}

// MARK: - View data

private extension HomeViewModel {

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
