//
//  MovieDetailsViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import Foundation

extension MovieDetailsViewState {

    func toggleFavorite() -> Self {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isFavorite.toggle()
        return .loaded(viewData)
    }
}
