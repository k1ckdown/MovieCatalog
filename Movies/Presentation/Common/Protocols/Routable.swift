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
}
