//
//  MainViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 03.11.2023.
//

extension HomeViewState {

    func failedLoadMore() -> HomeViewState {
        guard case .loaded(var viewData) = self else { return self }

        viewData.loadMore = .failed
        return .loaded(viewData)
    }

    func unavailableLoadMore() -> HomeViewState {
        guard case .loaded(var viewData) = self else { return self }

        viewData.loadMore = .unavailable
        return .loaded(viewData)
    }

    func loadedMore(_ items: [MovieDetailsItemViewModel]) -> HomeViewState {
        guard case .loaded(var viewData) = self else { return self }

        viewData.listItems.append(contentsOf: items)
        return .loaded(viewData)
    }
}
