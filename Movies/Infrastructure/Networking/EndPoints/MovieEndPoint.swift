//
//  MovieEndPoint.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum MovieEndPoint: EndPoint {
    case listByPage(Int)
    case detailsById(String)

    var path: String {
        "movies/"
    }

    var component: String {
        switch self {
        case .listByPage(let page):
            return "\(page)"
        case .detailsById(let id):
            return "details/" + id
        }
    }
}
