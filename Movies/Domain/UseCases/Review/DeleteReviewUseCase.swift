//
//  DeleteReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class DeleteReviewUseCase {

    private let closeSessionUseCase: CloseSessionUseCase
    private let reviewRepository: ReviewRepository

    init(
        closeSessionUseCase: CloseSessionUseCase,
        reviewRepository: ReviewRepository
    ) {
        self.closeSessionUseCase = closeSessionUseCase
        self.reviewRepository = reviewRepository
    }

    func execute(_ reviewId: String, movieId: String) async throws {
        do {
            try await reviewRepository.deleteReview(
                reviewId: reviewId,
                movieId: movieId
            )
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
