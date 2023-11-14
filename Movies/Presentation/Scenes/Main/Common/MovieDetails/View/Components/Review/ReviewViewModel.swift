//
//  ReviewViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct ReviewViewModel: Equatable, Identifiable {
    let id: String
    let rating: Int
    let isAnonymous: Bool
    let isUserReview: Bool
    let reviewText: String
    let createDateTime: String
    let authorNickname: String
    let authorAvatarLink: String
    let shouldShowAnonymous: Bool

    init(
        id: String,
        rating: Int,
        isAnonymous: Bool,
        isUserReview: Bool,
        reviewText: String?,
        createDateTime: Date,
        authorNickname: String?,
        authorAvatarLink: String?,
        shouldShowAnonymous: Bool
    ) {
        self.id = id
        self.rating = rating
        self.isAnonymous = isAnonymous
        self.isUserReview = isUserReview
        self.reviewText = reviewText ?? LocalizedKey.Content.notAvailable
        self.createDateTime = createDateTime.formatToDateMonthYear()
        self.authorNickname = authorNickname ?? LocalizedKey.Content.notAvailable
        self.authorAvatarLink = authorAvatarLink ?? ""
        self.shouldShowAnonymous = shouldShowAnonymous
    }
}

extension ReviewViewModel: HasPlaceholder {
    static func placeholder(id: String) -> ReviewViewModel {
        .init(
            id: id,
            rating: 9,
            isAnonymous: false,
            isUserReview: false,
            reviewText: .placeholder(length: 20),
            createDateTime: .now,
            authorNickname: .placeholder(length: 10),
            authorAvatarLink: nil,
            shouldShowAnonymous: false
        )
    }
}
