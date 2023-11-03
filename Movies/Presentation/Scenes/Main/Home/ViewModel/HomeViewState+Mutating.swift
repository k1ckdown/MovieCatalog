//
//  MainViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 03.11.2023.
//

extension HomeViewState {

    func loadedMore(_ items: [MovieDetailsItemViewModel]) -> Self {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.movieItems.append(contentsOf: items)
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
