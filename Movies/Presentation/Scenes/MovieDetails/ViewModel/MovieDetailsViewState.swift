//
//  MovieDetailsViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

struct MovieDetailsViewState: Equatable {
    let viewData: ViewData

    struct ViewData: Equatable {
        let genres: [String]
        let description: String
        let reviewViewModels: [ReviewViewModel]
        let descViewModel: AboutMovieViewModel
    }
}

enum MovieDetailsViewEvent {
    case favoriteToggled
    case addReviewTapped
    case editReviewTapped
    case deleteReviewTapped
    case reviewOptionsTapped
}
