//
//  UpdateReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class UpdateReviewUseCase {

    private let closeSessionUseCase: CloseSessionUseCase
    private let reviewRepository: ReviewRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        closeSessionUseCase: CloseSessionUseCase,
        reviewRepository: ReviewRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.closeSessionUseCase = closeSessionUseCase
        self.reviewRepository = reviewRepository
        self.keychainRepository = keychainRepository
    }

    func execute(_ review: ReviewModify, reviewId: String, movieId: String) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await reviewRepository.updateReview(
                review,
                reviewId: reviewId,
                movieId: movieId,
                token: token
            )
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
