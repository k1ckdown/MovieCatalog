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
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        movieRepository: MovieRepositoryProtocol,
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
    }

    func execute(_ movies: [MovieShort]) async throws -> [MovieDetails] {
        let movieIds = movies.map { $0.id }
        let userId = try? profileRepository.getProfileId()
        let token = try keychainRepository.retrieveToken()

        let movieDetailsList = try await withThrowingTaskGroup(
            of: MovieDetails.self,
            returning: [MovieDetails].self
        ) { taskGroup in
            for id in movieIds {
                taskGroup.addTask {
                    try await self.fetchDetails(id, userId: userId, token: token)
                }
            }

            return try await taskGroup.reduce(into: [MovieDetails]()) { result, movie in
                result.append(movie)
            }
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

    func fetchDetails(_ id: String, userId: String?, token: String) async throws -> MovieDetails {
        let movie = try await movieRepository.getMovie(id: id)
        let reviews = movie.reviews ?? []

        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        let averageRating = Double(totalRating) / Double(reviews.count)

        let userRating = reviews.first(where: { $0.author?.userId == userId })?.rating
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
            description: movie.description,
            director: movie.director,
            budget: movie.budget,
            fees: movie.fees,
            ageLimit: movie.ageLimit,
            rating: averageRating,
            userRating: userRating,
            isFavorite: movie.isFavorite
        )
    }
}
