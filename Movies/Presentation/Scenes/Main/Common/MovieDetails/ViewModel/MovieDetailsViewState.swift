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
        var reviewDialog: ReviewDialogViewModel?
        var selectedReview: ReviewViewModel?
        var movie: MovieDetailsView.Model

        var isConfirmationDialogPresenting = false
        var isReviewDialogPresented: Bool {
            reviewDialog != nil
        }
    }
}

enum MovieDetailsViewEvent {
    case onAppear
    case favoriteTapped

    case addReviewTapped
    case editReviewTapped
    case deleteReviewTapped

    case reviewOptionsTapped(String)
    case onConfirmationDialogPresented(Bool)
    case reviewDialogSentEvent(ReviewDialogViewEvent)
}
