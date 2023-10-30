//
//  ReviewDetails.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct ReviewDetails: Equatable, Hashable {
    let id: String
    let rating: Int
    let reviewText: String?
    let isAnonymous: Bool
    let createDateTime: Date
    let author: UserShort?
    let isUserReview: Bool
}

extension ReviewDetails {
    static let mock = ReviewDetails(
        id: "34",
        rating: 10,
        reviewText: "A very good movie. I advise you to watch it!",
        isAnonymous: false,
        createDateTime: .now,
        author: nil,
        isUserReview: false
    )
}
