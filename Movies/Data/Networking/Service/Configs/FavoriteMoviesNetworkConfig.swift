//
//  FavoriteMoviesNetworkConfig.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum FavoriteMoviesNetworkConfig: NetworkConfig {
    case list
    case add(movieId: String)
    case delete(movieId: String)

    var path: String {
        "favorites/"
    }

    var endPoint: String {
        switch self {
        case .list:
            return ""
        case .add(let movieId):
            return movieId + "/add"
        case .delete(let movieId):
            return movieId + "/delete"
        }
    }

    var task: HTTPTask {
        return .request
    }

    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .add:
            return .post
        case .delete:
            return .delete
        }
    }
}
