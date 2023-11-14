//
//  ReviewRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

final class ReviewRemoteDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ReviewRemoteDataSource {

    func deleteReview(token: String, movieId: String, reviewId: String) async throws {
        let config = ReviewNetworkConfig.delete(movieId: movieId, reviewId: reviewId)
        try await networkService.request(with: config, token: token)
    }

    func addReview(token: String, movieId: String, review: ReviewModify) async throws {
        let reviewDto = ReviewModifyDTO(
            reviewText: review.reviewText,
            rating: review.rating,
            isAnonymous: review.isAnonymous
        )

        let data = try networkService.encode(reviewDto)
        let config = ReviewNetworkConfig.add(movieId: movieId, review: data)

        try await networkService.request(with: config, token: token)
    }

    func updateReview(token: String, movieId: String, reviewId: String, review: ReviewModify) async throws {
        let reviewDto = ReviewModifyDTO(
            reviewText: review.reviewText,
            rating: review.rating,
            isAnonymous: review.isAnonymous
        )

        let data = try networkService.encode(reviewDto)
        let config = ReviewNetworkConfig.edit(movieId: movieId, reviewId: reviewId, review: data)

        try await networkService.request(with: config, token: token)
    }
}
