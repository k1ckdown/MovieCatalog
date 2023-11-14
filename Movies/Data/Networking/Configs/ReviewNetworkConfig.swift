//
//  ReviewNetworkConfig.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum ReviewNetworkConfig: NetworkConfig {
    case add(movieId: String, review: Data)
    case delete(movieId: String, reviewId: String)
    case edit(movieId: String, reviewId: String, review: Data)

    var path: String {
        "movie/"
    }

    var endPoint: String {
        switch self {
        case .add(let movieId, _):
            return movieId + "/review/add"
        case .delete(let movieId, let reviewId):
            return movieId + "/review/" + reviewId + "/delete"
        case .edit(let movieId, let reviewId, _):
            return movieId + "/review/" + reviewId + "/edit"
        }
    }

    var task: HTTPTask {
        switch self {
        case .delete:
            return .request
        case .add(_, let review):
            return .requestBody(review)
        case .edit(_, _, let review):
            return .requestBody(review)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .add:
            return .post
        case .edit:
            return .put
        case .delete:
            return .delete
        }
    }
}
