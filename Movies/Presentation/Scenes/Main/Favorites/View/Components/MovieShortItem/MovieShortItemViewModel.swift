//
//  MovieShortItemViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import Foundation

struct MovieShortItemViewModel: Identifiable, Equatable {
    let id: String
    let rating: Double
    let name: String?
    let imageUrl: String?

    static func == (
        lhs: MovieShortItemViewModel,
        rhs: MovieShortItemViewModel
    ) -> Bool {
        lhs.id == rhs.id
    }
}

extension MovieShortItemViewModel: HasPlaceholder {
    static func placeholder(id: String) -> MovieShortItemViewModel {
        .init(id: id, rating: 9, name: .placeholder(length: 10), imageUrl: "")
    }
}
