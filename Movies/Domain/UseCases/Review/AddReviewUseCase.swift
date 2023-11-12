//
//  AddReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class AddReviewUseCase {

    private let reviewRepository: ReviewRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        reviewRepository: ReviewRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.reviewRepository = reviewRepository
        self.keychainRepository = keychainRepository
    }

    func execute(review: ReviewModify, movieId: String) async throws {
        let token = try keychainRepository.retrieveToken()
        try await reviewRepository.addReview(review, movieId: movieId, token: token)
    }
}
