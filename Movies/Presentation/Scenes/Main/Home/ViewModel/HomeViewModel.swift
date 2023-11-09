//
//  HomeViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class HomeViewModel: ViewModel {

    @Published private(set) var state: HomeViewState

    private var movies = [MovieDetails]()
    private let coordinator: HomeCoordinatorProtocol
    private let fetchMoviesUseCase: FetchMoviesUseCase

    init(coordinator: HomeCoordinatorProtocol, fetchMoviesUseCase: FetchMoviesUseCase) {
        self.state = .idle
        self.coordinator = coordinator
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func handle(_ event: HomeViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .willDisplayLastItem:
            Task { await loadMore() }

        case .onSelectMovie(let id):
            movieSelected(id: id)
        }
    }
}

private extension HomeViewModel {

    func loadMore() async {
        do {
            let nextMovies = try await fetchMoviesUseCase.execute(.next)
            movies.append(contentsOf: nextMovies)

            let itemViewModels = nextMovies.map { makeItemViewModel($0) }
            state = state.loadedMore(itemViewModels)
        } catch let error as FetchMoviesUseCase.FetchMoviesError {
            state = error == .maxPagesReached ? state.unavailableLoadMore() : state.failedLoadMore()
        } catch {
            state = state.failedLoadMore()
        }
    }

    func movieSelected(id: String) {
        guard let movie = movies.first(where: { $0.id == id }) else {
            return
        }
        coordinator.showMovieDetails(movie)
    }

    func fetchMovies() async {
        state = .loading

        do {
            movies = try await fetchMoviesUseCase.execute(.first)
            let itemViewModels = movies.map { makeItemViewModel($0) }
            state = .loaded(.init(loadMore: .available, movieItems: itemViewModels))
        } catch {
            state = .error("\(error)")
        }
    }

    func makeItemViewModel(_ movie: MovieDetails) -> MovieDetailsItemViewModel {
        let genres = movie.genres ?? []
        let notAvailable = LocalizedKeysConstants.Content.notAvailable

        return .init(id: movie.id,
                     name: movie.name ?? notAvailable,
                     year: movie.year,
                     country: movie.country ?? notAvailable,
                     poster: movie.poster,
                     rating: movie.rating,
                     userRating: movie.userRating,
                     genres: genres.compactMap { $0.name },
                     shouldShowGenresEllipsis: genres.count > 5
        )
    }
}
