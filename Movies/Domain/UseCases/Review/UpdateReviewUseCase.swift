//
//  UpdateReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class UpdateReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(_ review: ReviewModify, reviewId: String, movieId: String) async throws {
        try await reviewRepository.updateReview(
            review,
            reviewId: reviewId,
            movieId: movieId
        )
    }
}
