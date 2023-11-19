//
//  AddReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class AddReviewUseCase {

    private let closeSessionUseCase: CloseSessionUseCase
    private let reviewRepository: ReviewRepository

    init(
        closeSessionUseCase: CloseSessionUseCase,
        reviewRepository: ReviewRepository
    ) {
        self.closeSessionUseCase = closeSessionUseCase
        self.reviewRepository = reviewRepository
    }

    func execute(review: ReviewModify, movieId: String) async throws {
        do {
            try await reviewRepository.addReview(review, movieId: movieId)
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
