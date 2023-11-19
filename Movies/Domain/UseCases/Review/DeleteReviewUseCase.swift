//
//  DeleteReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class DeleteReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(_ reviewId: String, movieId: String) async throws {
        try await reviewRepository.deleteReview(reviewId: reviewId, movieId: movieId)
    }
}
