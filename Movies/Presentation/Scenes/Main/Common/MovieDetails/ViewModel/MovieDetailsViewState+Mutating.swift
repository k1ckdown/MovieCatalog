//
//  MovieDetailsViewState+Mutating.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

// MARK: - Content

extension MovieDetailsViewState {

    func toggleFavorite() -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.detailsModel.isFavorite.toggle()
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

// MARK: - Review dialog

extension MovieDetailsViewState {

    func updateReviewText(_ text: String) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.reviewDialog?.text = text
        return .loaded(viewData)
    }

    func updateRating(_ rating: Int) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.reviewDialog?.rating = rating
        return .loaded(viewData)
    }

    func isAnonymous(_ value: Bool) -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.reviewDialog?.isAnonymous = value
        return .loaded(viewData)
    }

    func cancelReviewEditing() -> MovieDetailsViewState {
        guard case .loaded(var viewData) = self else {
            return self
        }

        viewData.reviewDialog = nil
        viewData.selectedReview = nil

        return .loaded(viewData)
    }

    func editReview() -> MovieDetailsViewState {
        guard
            case .loaded(var viewData) = self,
            let selectedReview = viewData.selectedReview
        else { return self }

        let reviewDialogViewModel = ReviewDialogViewModel(selectedReview)
        viewData.reviewDialog = .init(reviewDialogViewModel)

        return .loaded(viewData)
    }

    func reviewSelected(id: String) -> MovieDetailsViewState {
        guard
            case .loaded(var viewData) = self,
            let review = viewData.detailsModel.reviewViewModels.first(where: {
                $0.id == id
            })
        else { return self }

        viewData.selectedReview = review
        viewData.isConfirmationDialogPresenting = true

        return .loaded(viewData)
    }

    func saveReview() -> MovieDetailsViewState {
        guard
            case .loaded(var viewData) = self,
            let newReview = viewData.reviewDialog,
            let selectedReviewIndex = viewData.detailsModel.reviewViewModels.firstIndex(where: {
                $0.id == viewData.selectedReview?.id
            })
        else {
            return self
        }

        viewData.detailsModel.reviewViewModels[selectedReviewIndex].rating = newReview.rating
        viewData.detailsModel.reviewViewModels[selectedReviewIndex].reviewText = newReview.text
        viewData.detailsModel.reviewViewModels[selectedReviewIndex].isAnonymous = newReview.isAnonymous

        viewData.reviewDialog = nil
        viewData.selectedReview = nil

        return .loaded(viewData)
    }
}
