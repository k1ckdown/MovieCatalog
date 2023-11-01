//
//  HasPlaceholder.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol HasPlaceholder {
    static func placeholder(id: String) -> Self
}

extension Array where Element: HasPlaceholder {
    static func placeholders(count: Int) -> [Element] {
        (0..<count).map { .placeholder(id: "\($0)") }
    }
}
