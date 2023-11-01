//
//  FavoritesMovieItemViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 01.11.2023.
//

import Foundation

struct FavoritesMovieItemViewModel: Identifiable, Equatable {
    let id = UUID()
    let rating: Int?
    let imageUrl: String?
    let size: FavoritesMovieItemView.Size

    static func == (
        lhs: FavoritesMovieItemViewModel,
        rhs: FavoritesMovieItemViewModel
    ) -> Bool {
        lhs.id == rhs.id
    }
}
