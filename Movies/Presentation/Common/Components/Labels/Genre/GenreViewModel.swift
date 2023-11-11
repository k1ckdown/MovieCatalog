//
//  GenreViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

struct GenreViewModel: Equatable, Identifiable {
    let id: String
    let name: String
    let style: GenreTag.Style
}

extension GenreViewModel: HasPlaceholder {
    static func placeholder(id: String) -> GenreViewModel {
        .init(id: id, name: .placeholder(length: 7), style: .body)
    }
}
