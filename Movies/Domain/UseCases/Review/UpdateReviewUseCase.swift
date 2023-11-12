//
//  UpdateReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class UpdateReviewUseCase {

    private let reviewRepository: ReviewRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        reviewRepository: ReviewRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
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
                try keychainRepository.deleteToken()
            }

            throw error
        }
    }
}
