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
        var isFavorite: Bool
        var isDialogPresenting = false
        let model: MovieDetailsView.Model
    }
}

enum MovieDetailsViewEvent {
    case onAppear
    case favoriteTapped
    case addReviewTapped
    case editReviewTapped
    case deleteReviewTapped
    case reviewOptionsTapped
    case onDialogPresented(Bool)
}
