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
        viewData.reviewDialog = .init(viewModel: reviewDialogViewModel)

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

    func saveReview(_ review: ReviewDialogViewModel) -> MovieDetailsViewState {
        guard
            case .loaded(var viewData) = self,
            let selectedReviewIndex = viewData.detailsModel.reviewViewModels.firstIndex(where: {
                $0.id == viewData.selectedReview?.id
            })
        else {
            return self
        }

        viewData.detailsModel.reviewViewModels[selectedReviewIndex].rating = review.rating
        viewData.detailsModel.reviewViewModels[selectedReviewIndex].reviewText = review.text
        viewData.detailsModel.reviewViewModels[selectedReviewIndex].isAnonymous = review.isAnonymous

        viewData.reviewDialog = nil
        viewData.selectedReview = nil

        return .loaded(viewData)
    }
}
