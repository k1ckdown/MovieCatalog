//
//  MovieObject.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import RealmSwift

final class MovieObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?
    @Persisted var poster: String?
    @Persisted var year: Int
    @Persisted var country: String?
    @Persisted var time: Int
    @Persisted var tagline: String?
    @Persisted var desc: String?
    @Persisted var director: String?
    @Persisted var budget: Int?
    @Persisted var fees: Int?
    @Persisted var ageLimit: Int
    @Persisted var isFavorite: Bool
    @Persisted var genres: List<GenreObject>
    @Persisted var reviews: List<ReviewObject>

    convenience init(_ movie: Movie) {
        self.init()

        id = movie.id
        name = movie.name
        poster = movie.poster
        year = movie.year
        country = movie.country
        time = movie.time
        tagline = movie.tagline
        desc = movie.description
        director = movie.director
        budget = movie.budget
        fees = movie.fees
        ageLimit = movie.ageLimit
        isFavorite = true
        movie.genres?.forEach { genres.append(GenreObject($0)) }
        movie.reviews?.forEach { reviews.append(ReviewObject($0)) }
    }

    func toDomain() -> Movie {
        Movie(
            id: id,
            name: name,
            poster: poster,
            year: year,
            country: country,
            genres: genres.isEmpty ? nil : genres.map { $0.toDomain() },
            reviews: reviews.isEmpty ? nil : reviews.map { $0.toDomain() },
            time: time,
            tagline: tagline,
            description: desc,
            director: director,
            budget: budget,
            fees: fees,
            ageLimit: ageLimit,
            isFavorite: isFavorite
        )
    }
}
