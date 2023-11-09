//
//  MovieDetailsItemViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct MovieDetailsItemViewModel: Identifiable, Equatable {
    let id: String
    let name: String
    let year: Int
    let country: String
    let poster: String?
    let rating: Double
    let userRating: Int?
    let genres: [String]
    let shouldShowGenresEllipsis: Bool
}

extension MovieDetailsItemViewModel: HasPlaceholder {
    static func placeholder(id: String) -> MovieDetailsItemViewModel {
        .init(
            id: id,
            name: .placeholder(length: 20),
            year: 0,
            country: .placeholder(length: 5),
            poster: "",
            rating: 10,
            userRating: nil,
            genres: [],
            shouldShowGenresEllipsis: false
        )
    }
}
