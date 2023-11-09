//
//  FavoritesViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FavoritesViewModel: ViewModel {

    @Published private(set) var state: FavoritesViewState

    private var movies = [MovieDetails]()
    private let coordinator: FavoritesCoordinatorProtocol
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase

    init(
        coordinator: FavoritesCoordinatorProtocol,
        fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    ) {
        state = .idle
        self.coordinator = coordinator
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    }

    func handle(_ event: FavoritesViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }

        case .onSelectMovie(let id):
            movieSelected(id)
        }
    }
}

private extension FavoritesViewModel {

    func movieSelected(_ id: String) {
        if let movie = movies.first(where: { $0.id == id }) {
            coordinator.showMovieDetails(movie)
        }
    }

    func fetchMovies() async {
        state = .loading

        do {
            movies = try await fetchFavoriteMoviesUseCase.execute()
            let itemViewModels = movies.map { makeMovieItemViewModel($0) }
            state = .loaded(.init(movieItems: itemViewModels))
        } catch {
            if error as? AuthError == .unauthorized {
                coordinator.showAuthScene()
            } else {
                state = .error(error.localizedDescription)
            }
        }
    }

    func makeMovieItemViewModel(_ movie: MovieDetails) -> MovieShortItemViewModel {
        .init(id: movie.id, rating: movie.rating, name: movie.name, imageUrl: movie.poster)
    }
}
