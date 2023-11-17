//
//  HomeViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum HomeViewEvent {
    case onAppear
    case willDisplayLastMovie
    case onSelectMovie(String)
}

enum HomeViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        enum LoadMore: Equatable {
            case failed
            case available
            case unavailable
        }

        var loadMore: LoadMore
        var cardItems: [MovieDetailsItemViewModel]
        var listItems: [MovieDetailsItemViewModel]
    }
}
