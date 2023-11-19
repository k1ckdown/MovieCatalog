//
//  getMovieDetailsUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class GetMovieDetailsUseCase {

    private let movieRepository: MovieRepository
    private let profileRepository: ProfileRepository

    init(
        movieRepository: MovieRepository,
        profileRepository: ProfileRepository
    ) {
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
    }

    func execute(_ movies: [Movie]) async throws -> [MovieDetails] {
        let userId = try? await profileRepository.getProfile().id
        return movies.map { makeMovieDetails(for: $0, userId: userId) }
    }
}

private extension GetMovieDetailsUseCase {

    func makeReviewDetails(for review: Review, isUserReview: Bool) -> ReviewDetails {
        .init(
            id: review.id,
            rating: review.rating,
            reviewText: review.reviewText,
            isAnonymous: review.isAnonymous,
            createDateTime: review.createDateTime,
            author: review.author,
            isUserReview: isUserReview
        )
    }

    func makeMovieDetails(for movie: Movie, userId: String?) -> MovieDetails {
        let reviews = movie.reviews ?? []

        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        let averageRating = Double(totalRating) / Double(reviews.count)

        let userReview = reviews.first(where: { $0.author?.userId == userId })
        let reviewDetailsList = reviews.map {
            makeReviewDetails(for: $0, isUserReview: $0.id == userReview?.id)
        }
        
        return .init(
            id: movie.id,
            name: movie.name,
            poster: movie.poster,
            year: movie.year,
            country: movie.country,
            genres: movie.genres,
            reviews: reviewDetailsList,
            time: movie.time,
            tagline: movie.tagline,
            description: movie.description,
            director: movie.director,
            budget: movie.budget,
            fees: movie.fees,
            ageLimit: movie.ageLimit,
            rating: averageRating,
            userRating: userReview?.rating,
            isFavorite: movie.isFavorite
        )
    }
}
