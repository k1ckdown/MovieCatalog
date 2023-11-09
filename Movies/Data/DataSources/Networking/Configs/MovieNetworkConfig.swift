//
//  MovieNetworkConfig.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum MovieNetworkConfig: NetworkConfig {
    case listByPage(Int)
    case detailsById(String)

    var path: String {
        "movies/"
    }

    var endPoint: String {
        switch self {
        case .listByPage(let page):
            return "\(page)"
        case .detailsById(let id):
            return "details/" + id
        }
    }

    var task: HTTPTask {
        .request
    }

    var method: HTTPMethod {
        .get
    }
}
