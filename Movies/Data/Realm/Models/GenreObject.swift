//
//  GenreObject.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import RealmSwift

final class GenreObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?

    convenience init(_ genre: Genre) {
        self.init()

        id = genre.id
        name = genre.name
    }

    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
