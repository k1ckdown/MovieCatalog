//
//  MovieShort.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct MovieShort {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [Genre]?
    let reviews: [ReviewShort]?
}
