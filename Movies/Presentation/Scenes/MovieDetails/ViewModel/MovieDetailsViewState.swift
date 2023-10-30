//
//  MovieDetailsViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum MovieDetailsViewState: Equatable {
    case loading
    case loaded(ViewData)

    struct ViewData: Equatable {
        let isFavorite: Bool
        let genres: [String]?
        let description: String
        let reviewViewModels: [ReviewViewModel]?
        let aboutMovieViewModel: AboutMovieViewModel
    }
}

enum MovieDetailsViewEvent {
    case onAppear
    case addReviewTapped
    case editReviewTapped
    case deleteReviewTapped
    case reviewOptionsTapped
    case favoriteToggled(Bool)
}
