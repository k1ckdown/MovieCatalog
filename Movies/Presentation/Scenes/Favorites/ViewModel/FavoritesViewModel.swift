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
        
    }
}
