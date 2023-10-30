//
//  Genre.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct Genre {
    let id: String
    let name: String?
}

extension Genre {
    static let mock = Genre(id: "id", name: "боевик")
}
