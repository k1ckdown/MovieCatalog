//
//  MovieShortDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct MovieShortDTO: Decodable {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [GenreDTO]?
    let reviews: [ReviewShortDTO]?

    func toDomain() -> MovieShort {
        .init(
            id: id,
            name: name,
            poster: poster,
            year: year,
            country: country,
            genres: genres?.map { $0.toDomain() },
            reviews: reviews?.map { $0.toDomain() }
        )
    }
}

struct MoviesResponse: Decodable {
    let movies: [MovieShortDTO]
}

struct MoviesPagedResponse: Decodable {
    let movies: [MovieShortDTO]
    let pageInfo: PageInfo

    struct PageInfo: Decodable {
        let pageSize: Int
        let pageCount: Int
        let currentPage: Int
    }
}
