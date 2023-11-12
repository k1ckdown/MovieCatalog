//
//  MainViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 03.11.2023.
//

extension HomeViewState {

    func failedLoadMore() -> HomeViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.loadMore = .failed
        return .loaded(viewData)
    }

    func unavailableLoadMore() -> HomeViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.loadMore = .unavailable
        return .loaded(viewData)
    }

    func loadedMore(_ items: [MovieDetailsItemViewModel]) -> HomeViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.movieItems.append(contentsOf: items)
        return .loaded(viewData)
    }

    func userRatingUpdated(_ rating: Int?, movieId: String) -> HomeViewState {
        guard
            case .loaded(var viewData) = self,
            let movieIndex = viewData.movieItems.firstIndex(where: {
                $0.id == movieId
            })
        else { return self }

        viewData.movieItems[movieIndex].userRating = rating
        return .loaded(viewData)
    }
}
