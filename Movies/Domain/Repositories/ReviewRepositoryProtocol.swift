//
//  ReviewRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

protocol ReviewRepositoryProtocol {
    func deleteReview(reviewId: String, movieId: String, token: String) async throws
    func addReview(_ review: ReviewModify, movieId: String, token: String) async throws
    func updateReview(
        _ review: ReviewModify,
        reviewId: String,
        movieId: String,
        token: String
    ) async throws
}
