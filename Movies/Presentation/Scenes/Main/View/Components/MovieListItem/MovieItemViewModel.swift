//
//  MovieItemViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct MovieItemViewModel: Identifiable, Equatable {
    let id: String
    let name: String
    let year: Int
    let country: String
    let poster: String
    let rating: Double
    let userRating: Int?
    let genres: [String]
    let shouldShowGenresEllipsis: Bool
}

extension MovieItemViewModel: HasPlaceholder {
    static func placeholder(id: String) -> MovieItemViewModel {
        .init(
            id: id,
            name: .placeholder(length: 20),
            year: 0,
            country: .placeholder(length: 5),
            poster: "",
            rating: Double.random(in: 1...10),
            userRating: nil,
            genres: [],
            shouldShowGenresEllipsis: false
        )
    }
}
