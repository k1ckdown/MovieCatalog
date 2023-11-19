//
//  ReviewRepositoryImplementation.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class ReviewRepositoryImplementation {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ReviewRepositoryImplementation: ReviewRepository {

    func deleteReview(reviewId: String, movieId: String) async throws {
        let config = ReviewNetworkConfig.delete(movieId: movieId, reviewId: reviewId)
        try await networkService.request(with: config, useToken: true)
    }

    func addReview(_ review: ReviewModify, movieId: String) async throws {
        let data = try encodeReviewModify(review)
        let config = ReviewNetworkConfig.add(movieId: movieId, review: data)

        try await networkService.request(with: config, useToken: true)
    }

    func updateReview(_ review: ReviewModify, reviewId: String, movieId: String) async throws {
        let data = try encodeReviewModify(review)
        let config = ReviewNetworkConfig.edit(movieId: movieId, reviewId: reviewId, review: data)

        try await networkService.request(with: config, useToken: true)
    }
}

private extension ReviewRepositoryImplementation {

    func encodeReviewModify(_ reviewModify: ReviewModify) throws -> Data {
        let reviewDto = ReviewModifyDTO(
            reviewText: reviewModify.reviewText,
            rating: reviewModify.rating,
            isAnonymous: reviewModify.isAnonymous
        )

        return try networkService.encode(reviewDto)
    }
}
