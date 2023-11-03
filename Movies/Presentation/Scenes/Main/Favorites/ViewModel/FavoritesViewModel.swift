//
//  FavoritesViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FavoritesViewModel: ViewModel {

    @Published private(set) var state: FavoritesViewState
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase

    init(fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase) {
        state = .idle
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    }

    func handle(_ event: FavoritesViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchMovies() }
        }
    }
}

private extension FavoritesViewModel {

    func fetchMovies() async {
        state = .loading

        do {
            let movies = try await fetchFavoriteMoviesUseCase.execute()
            let itemViewModels = movies.map { makeMovieItemViewModel($0) }
            state = .loaded(.init(movieItems: itemViewModels))
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func makeMovieItemViewModel(_ movie: MovieDetails) -> MovieShortItemViewModel {
        .init(rating: movie.userRating, name: movie.name, imageUrl: movie.poster)
    }
}
