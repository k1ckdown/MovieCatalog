//
//  ReviewViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct ReviewViewModel: Equatable, Identifiable {
    let id: String
    let rating: Double
    let isUserReview: Bool
    let reviewText: String
    let createDateTime: String
    let authorNickname: String
    let authorAvatarLink: String

    init(
        id: String,
        rating: Int,
        isUserReview: Bool,
        reviewText: String?,
        createDateTime: Date,
        authorNickname: String?,
        authorAvatarLink: String?
    ) {
        self.id = id
        self.rating = Double(rating)
        self.isUserReview = isUserReview
        self.reviewText = reviewText ?? LocalizedKey.Content.notAvailable
        self.createDateTime = createDateTime.formatToDateMonthYear()
        self.authorNickname = authorNickname ?? LocalizedKey.Content.notAvailable
        self.authorAvatarLink = authorAvatarLink ?? ""
    }
}

extension ReviewViewModel: HasPlaceholder {
    static func placeholder(id: String) -> ReviewViewModel {
        .init(
            id: id,
            rating: 9,
            isUserReview: false,
            reviewText: .placeholder(length: 20),
            createDateTime: .now,
            authorNickname: .placeholder(length: 10),
            authorAvatarLink: nil
        )
    }
}
