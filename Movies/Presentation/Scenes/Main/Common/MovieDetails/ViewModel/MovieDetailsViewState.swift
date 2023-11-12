//
//  MovieDetailsViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum MovieDetailsViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        struct ReviewDialog: Equatable {
            var isLoading = false
            let viewModel: ReviewDialogViewModel
        }

        var reviewDialog: ReviewDialog?
        var selectedReview: ReviewViewModel?
        var detailsModel: MovieDetailsView.Model

        var isConfirmationDialogPresenting = false
        var isReviewDialogPresented: Bool {
            reviewDialog != nil
        }
    }
}

enum MovieDetailsViewEvent {
    case onAppear
    case favoriteTapped

    case cancelReviewTapped
    case saveReviewTapped(ReviewDialogViewModel)

    case editReviewTapped
    case deleteReviewTapped

    case reviewOptionsTapped(String)
    case onConfirmationDialogPresented(Bool)
}
