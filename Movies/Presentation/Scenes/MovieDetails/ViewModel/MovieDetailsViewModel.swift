//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieDetailsViewModel: ViewModel {

    @Published private(set) var state: MovieDetailsViewState
    private let movie: MovieDetails

    init(movieDetails: MovieDetails) {
        movie = movieDetails
        state = .idle
    }

    func handle(_ event: MovieDetailsViewEvent) {
        switch event {
        case .onAppear:
            state = .loaded(getViewData())
        case .favoriteTapped:
            state = state.toggleFavorite()

        default: break
        }
    }
}

private extension MovieDetailsViewModel {

    func getViewData() -> MovieDetailsViewState.ViewData {
        let genres = movie.genres?.compactMap { $0.name }

        let aboutMovieViewModel = makeAboutMovieViewModel(movie)
        let reviewViewModels = movie.reviews?.compactMap { makeReviewViewModel(review: $0) }

        return .init(
            name: movie.name,
            rating: movie.rating,
            poster: movie.poster,
            isFavorite: false,
            genres: genres,
            description: movie.description,
            reviewViewModels: reviewViewModels,
            aboutMovieViewModel: aboutMovieViewModel
        )
    }

    func makeReviewViewModel(review: ReviewDetails) -> ReviewViewModel {
        .init(
            rating: review.rating,
            isUserReview: review.isUserReview,
            reviewText: review.reviewText,
            createDateTime: review.createDateTime,
            authorNickname: review.author?.nickName,
            authorAvatarLink: review.author?.avatar
        )
    }

    func makeAboutMovieViewModel(_ movie: MovieDetails) -> AboutMovieViewModel {
        let notAvailable = LocalizedKeysConstants.Content.notAvailable

        return .init(
            year: movie.year,
            country: movie.country ?? notAvailable,
            tagline: movie.tagline ?? notAvailable,
            director: movie.director ?? notAvailable,
            budget: getMonetaryDescription(value: movie.budget),
            fees: getMonetaryDescription(value: movie.fees),
            ageLimit: movie.ageLimit,
            time: movie.time
        )
    }

    func getMonetaryDescription(value: Int?) -> String {
        if let value {
            return "$\(value.formatted())"
        }

        return LocalizedKeysConstants.Content.notAvailable
    }
}
