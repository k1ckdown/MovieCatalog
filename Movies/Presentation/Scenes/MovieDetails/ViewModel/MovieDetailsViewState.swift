//
//  MovieDetailsViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

enum MovieDetailsViewState: Equatable {
    case idle
    case loaded(ViewData)

    struct ViewData: Equatable {
        let name: String?
        let rating: Double
        let poster: String?
        var isFavorite: Bool
        let genres: [String]?
        let description: String?
        let reviewViewModels: [ReviewViewModel]?
        let aboutMovieViewModel: AboutMovieViewModel
    }
}

enum MovieDetailsViewEvent {
    case onAppear
    case favoriteTapped
    case addReviewTapped
    case editReviewTapped
    case deleteReviewTapped
    case reviewOptionsTapped
}
