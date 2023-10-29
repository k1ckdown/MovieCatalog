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
    let year: String
    let country: String
    let poster: String
    let rating: Double
    let userRating: Double?
    let genres: [String]
    let shouldShowGenresEllipsis: Bool
}
