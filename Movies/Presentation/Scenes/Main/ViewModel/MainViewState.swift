//
//  MainViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum MainViewEvent {
    case onAppear
    case willDisplayLastItem
    case onSelectMovie(String)
}

enum MainViewState: Equatable {
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
        var listMovies: [MovieDetailsItemViewModel]
        let cardMovies: [MovieDetailsItemViewModel]
    }
}

extension MainViewState {

    func loadedMore(_ items: [MovieDetailsItemViewModel]) -> Self {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.listMovies.append(contentsOf: items)
        return .loaded(viewData)
    }

    func unavailableLoadMore() -> Self {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.loadMore = .unavailable
        return .loaded(viewData)
    }

    func failedLoadMore() -> Self {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.loadMore = .failed
        return .loaded(viewData)
    }
}
