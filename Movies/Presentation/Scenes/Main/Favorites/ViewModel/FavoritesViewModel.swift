//
//  FavoritesViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FavoritesViewModel: ViewModel {

    @Published private(set) var state: FavoritesViewState

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
            coordinator.showMovieDetails(id)
        }
    }
}

private extension FavoritesViewModel {

    func fetchMovies() async {
        if case .idle = state {
            state = .loading
        }

        do {
            let movies = try await fetchFavoriteMoviesUseCase.execute()
            state = .loaded(getViewData(movies))
        } catch {
            if error as? AuthError == .unauthorized {
                coordinator.showAuthScene()
            } else {
                state = .error(error.localizedDescription)
            }
        }
    }
}

// MARK: - View data

private extension FavoritesViewModel {

    func getViewData(_ movies: [Movie]) -> FavoritesViewState.ViewData {
        let itemViewModels = makeMovieItemViewModels(movies)
        return .init(shouldShowPlaceholder: itemViewModels.isEmpty, movieItems: itemViewModels)
    }

    func makeMovieItemViewModels(_ movies: [Movie]) -> [MovieShortItemViewModel] {
        movies.map { movie in
            MovieShortItemViewModel(
                id: movie.id,
                rating: movie.getAverageRating(),
                name: movie.name,
                imageUrl: movie.poster
            )
        }
    }
}
