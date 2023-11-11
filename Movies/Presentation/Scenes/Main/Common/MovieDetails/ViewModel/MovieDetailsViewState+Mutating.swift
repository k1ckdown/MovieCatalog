//
//  MovieDetailsViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import Foundation

extension MovieDetailsViewState {

    func toggleFavorite() -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isFavorite.toggle()
        return .loaded(viewData)
    }

    func confirmationDialog(isPresented: Bool) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isDialogPresenting = isPresented
        return .loaded(viewData)
    }
}
