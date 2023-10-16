//
//  MovieDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct MovieDTO: Decodable {
    let id: String
    let name: String?
    let poster: URL?
    let year: Int
    let country: String?
    let genres: [GenreDTO]?
    let reviews: [ReviewShortDTO]?
}

struct MoviesResponse: Decodable {
    let movies: [MovieDTO]
    let pageInfo: PageInfo

    struct PageInfo: Decodable {
        let pageSize: Int
        let pageCount: Int
        let currentPage: Int
    }
}
