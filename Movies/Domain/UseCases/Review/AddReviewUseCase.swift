//
//  AddReviewUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class AddReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(review: ReviewModify, movieId: String) async throws {
        try await reviewRepository.addReview(review, movieId: movieId)
    }
}
