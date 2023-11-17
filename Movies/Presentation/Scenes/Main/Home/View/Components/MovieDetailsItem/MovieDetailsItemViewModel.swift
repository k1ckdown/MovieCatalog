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
    let year: String
    let country: String
    let poster: String?
    let rating: Double
    var userRating: Int?
    let genres: [GenreViewModel]
    let shouldShowGenresEllipsis: Bool
    
    init(
        id: String,
        name: String?,
        year: Int,
        country: String?,
        poster: String?,
        rating: Double,
        userRating: Int?,
        genres: [Genre]?
    ) {
        self.id = id
        self.name = name ?? LocalizedKey.Movie.notAvailable
        self.year = "\(year)"
        self.country = country ?? LocalizedKey.Movie.notAvailable
        self.poster = poster
        self.rating = rating
        self.userRating = userRating
        self.genres = genres?.map {
            .init(id: $0.id, name: $0.name ?? "", style: .note)
        } ?? []
        self.shouldShowGenresEllipsis = self.genres.count > 5
    }
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
            genres: []
        )
    }
}
