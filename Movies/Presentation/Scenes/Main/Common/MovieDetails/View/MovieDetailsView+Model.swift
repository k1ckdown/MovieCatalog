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
        let genres: [GenreViewModel]
        let description: String
        let reviewViewModels: [ReviewViewModel]
        let aboutMovieViewModel: AboutMovieViewModel
    }
}

extension MovieDetailsView.Model: HasPlaceholder {
    static func placeholder(id: String = "") -> MovieDetailsView.Model {
        .init(
            name: .placeholder(length: 13),
            rating: 10,
            poster: nil,
            genres: .placeholders(count: 4),
            description: .placeholder(length: 60),
            reviewViewModels: .placeholders(count: 4),
            aboutMovieViewModel: .placeholder()
        )
    }
}

