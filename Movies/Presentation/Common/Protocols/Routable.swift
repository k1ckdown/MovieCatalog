//
//  Routable.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

protocol Routable: Hashable, Identifiable {}

extension Routable {
    var id: String {
        String(describing: self)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
