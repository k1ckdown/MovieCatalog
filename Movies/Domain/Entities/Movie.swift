//
//  Movie.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct Movie {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [Genre]?
    let reviews: [Review]?
    let time: Int
    let tagline: String?
    let description: String?
    let director: String?
    let budget: Int?
    let fees: Int?
    let ageLimit: Int
    var isFavorite = false
    var isPaged = true

    func getAverageRating() -> Double? {
        guard let reviews else { return nil }

        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        let averageRating = Double(totalRating) / Double(reviews.count)
        
        return averageRating
    }
}
