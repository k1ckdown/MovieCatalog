//
//  FavoritesViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

enum FavoritesViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        let movieItems: [MovieShortItemViewModel]
    }
}

enum FavoritesViewEvent {
    case onAppear
}
