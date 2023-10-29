//
//  Movie.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct Movie {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [Genre]?
    let reviews: [ReviewShort]?
}

struct MoviesPaged {
    let movies: [Movie]
    let pageInfo: PageInfo

    struct PageInfo {
        let pageSize: Int
        let pageCount: Int
        let currentPage: Int
    }
}
