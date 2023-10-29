//
//  MainViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

enum MainViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        let cardMovies: [MovieItemViewModel]
        let listMovies: [MovieItemViewModel]
    }
}

enum MainViewEvent {
    case onAppear
    case onSelectMovie(String)
}
