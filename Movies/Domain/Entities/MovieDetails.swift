//
//  Movie.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

struct MovieDetails {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [Genre]?
    let reviews: [ReviewDetails]?
    let time: Int
    let tagline: String?
    let description: String?
    let director: String?
    let budget: Int?
    let fees: Int?
    let ageLimit: Int
    let rating: Double
}
