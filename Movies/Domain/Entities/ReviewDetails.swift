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
