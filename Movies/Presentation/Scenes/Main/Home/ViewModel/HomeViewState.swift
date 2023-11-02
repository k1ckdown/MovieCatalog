//
//  HomeViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum HomeViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        let cardMovies: [MovieDetailsItemViewModel]
        let listMovies: [MovieDetailsItemViewModel]
    }
}

enum HomeViewEvent {
    case onAppear
    case onSelectMovie(String)
    case willDisplayItem(String)
}
