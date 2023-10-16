//
//  MovieDetailsDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct MovieDetailsDTO: Decodable {
    let id: String
    let name: String?
    let poster: URL?
    let year: Int
    let country: String?
    let genres: [GenreDTO]?
    let reviews: [ReviewDTO]?
    let time: Int
    let tagline: String?
    let description: String?
    let director: String?
    let budget: Int?
    let fees: Int?
    let ageLimit: Int
}
