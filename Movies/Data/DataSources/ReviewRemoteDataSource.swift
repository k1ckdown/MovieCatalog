//
//  ReviewRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol ReviewRemoteDataSource {
    func deleteReview(token: String, movieId: String, reviewId: String) async throws
    func addReview(token: String, movieId: String, review: ReviewModifyDTO) async throws
    func updateReview(token: String, movieId: String, reviewId: String, review: ReviewModifyDTO) async throws
}
