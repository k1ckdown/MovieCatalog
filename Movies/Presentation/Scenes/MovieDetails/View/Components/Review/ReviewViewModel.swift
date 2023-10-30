//
//  ReviewViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct ReviewViewModel: Equatable, Identifiable {
    let id = UUID()
    let rating: Int
    let isUserReview: Bool
    let reviewText: String?
    let createDateTime: Date
    let authorNickname: String?
    let authorAvatarLink: String?
}
