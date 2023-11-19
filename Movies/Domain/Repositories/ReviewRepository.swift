//
//  ReviewRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

protocol ReviewRepository {
    func deleteReview(reviewId: String, movieId: String) async throws
    func addReview(_ review: ReviewModify, movieId: String) async throws
    func updateReview(_ review: ReviewModify, reviewId: String, movieId: String) async throws
}
