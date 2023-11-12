//
//  MovieDetailsViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

extension MovieDetailsViewState {

    func toggleFavorite() -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isFavorite.toggle()
        return .loaded(viewData)
    }

    func reviewDialog(isPresented: Bool) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isReviewDialogPresenting = isPresented
        return .loaded(viewData)
    }

    func confirmationDialog(isPresented: Bool) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.isConfirmationDialogPresenting = isPresented
        return .loaded(viewData)
    }
}
