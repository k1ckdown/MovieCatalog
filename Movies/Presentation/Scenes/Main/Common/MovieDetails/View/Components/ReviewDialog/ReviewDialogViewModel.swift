//
//  ReviewDialogViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

struct ReviewDialogViewModel: Equatable {
    var rating: Int
    var text: String
    var isAnonymous: Bool

    init(_ reviewViewModel: ReviewViewModel) {
        rating = reviewViewModel.rating
        text = reviewViewModel.reviewText
        isAnonymous = reviewViewModel.isAnonymous
    }
}
