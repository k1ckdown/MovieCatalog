//
//  ReviewRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class ReviewRepository {

    private let reviewRemoteDataSource: ReviewRemoteDataSource

    init(reviewRemoteDataSource: ReviewRemoteDataSource) {
        self.reviewRemoteDataSource = reviewRemoteDataSource
    }
}

extension ReviewRepository: ReviewRepositoryProtocol {

    func deleteReview(reviewId: String, movieId: String, token: String) async throws {
        try await reviewRemoteDataSource.deleteReview(token: token, movieId: movieId, reviewId: reviewId)
    }
    
    func addReview(_ review: ReviewModify, movieId: String, token: String) async throws {
        try await reviewRemoteDataSource.addReview(token: token, movieId: movieId, review: review)
    }
    
    func updateReview(
        _ review: ReviewModify,
        reviewId: String,
        movieId: String,
        token: String
    ) async throws {
        try await reviewRemoteDataSource.updateReview(
            token: token,
            movieId: movieId,
            reviewId: reviewId,
            review: review
        )
    }
}
