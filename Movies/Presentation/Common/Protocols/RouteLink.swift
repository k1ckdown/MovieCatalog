//
//  RouteLink.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import Foundation

protocol RouteLink: Hashable, Identifiable {}

extension RouteLink {
    var id: String {
        String(describing: self)
    }
}
