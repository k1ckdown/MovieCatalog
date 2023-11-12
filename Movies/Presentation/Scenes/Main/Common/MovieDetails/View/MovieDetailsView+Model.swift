//
//  MovieDetailsView+Model.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

extension MovieDetailsView {

    struct Model: Equatable {
        let name: String
        let rating: Double
        let poster: String?
        var isFavorite: Bool
        let description: String
        let genres: [GenreViewModel]
        var reviewViewModels: [ReviewViewModel]
        let aboutMovieViewModel: AboutMovieViewModel
    }
}

extension MovieDetailsView.Model: HasPlaceholder {
    static func placeholder(id: String = "") -> MovieDetailsView.Model {
        .init(
            name: .placeholder(length: 13),
            rating: 10,
            poster: nil,
            isFavorite: false,
            description: .placeholder(length: 60),
            genres: .placeholders(count: 4),
            reviewViewModels: .placeholders(count: 4),
            aboutMovieViewModel: .placeholder()
        )
    }
}

