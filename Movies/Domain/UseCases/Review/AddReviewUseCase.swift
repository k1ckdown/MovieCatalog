//
//  AddReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class AddReviewUseCase {

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

    func execute(review: ReviewModify, movieId: String) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await reviewRepository.addReview(review, movieId: movieId, token: token)
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
