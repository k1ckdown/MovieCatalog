//
//  MainViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum MainViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        let cardMovies: [MovieDetailsItemViewModel]
        let listMovies: [MovieDetailsItemViewModel]
    }
}

enum MainViewEvent {
    case onAppear
    case onSelectMovie(String)
}
