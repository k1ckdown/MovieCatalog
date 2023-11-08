//
//  GetDetailsFromMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class GetDetailsFromMoviesUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let profileRepository: ProfileRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol, profileRepository: ProfileRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
    }

    func execute(_ movies: [MovieShort]) async throws -> [MovieDetails] {
        let userId = try? await profileRepository.getProfile().id
        var movieDetailsList = [MovieDetails]()

        for movie in movies {
            let movieDetail = try await fetchDetails(movie.id, userId: userId)
            movieDetailsList.append(movieDetail)
        }

        return movieDetailsList
    }
}

private extension GetDetailsFromMoviesUseCase {

    func getReviewDetails(_ review: Review, isUserReview: Bool) -> ReviewDetails {
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

    func fetchDetails(_ id: String, userId: String?) async throws -> MovieDetails {
        let movie = try await movieRepository.getMovie(id: id)
        let reviews = movie.reviews ?? []

        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        let averageRating = Double(totalRating) / Double(reviews.count)

        let userRating = reviews.first(where: { $0.id == userId })?.rating
        let reviewDetailsList = reviews.map {
            getReviewDetails($0, isUserReview: $0.id == userId)
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
            description: movie.director,
            director: movie.director,
            budget: movie.budget,
            fees: movie.fees,
            ageLimit: movie.ageLimit,
            rating: averageRating,
            userRating: userRating
        )
    }
}
