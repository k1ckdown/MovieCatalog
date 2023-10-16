//
//  UserNetworkConfig.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum UserNetworkConfig: NetworkConfig {
    case retrieveProfile
    case updateProfile(Data)

    var path: String {
        "account/"
    }

    var endPoint: String {
        "profile"
    }

    var task: HTTPTask {
        switch self {
        case .retrieveProfile:
            return .request
        case .updateProfile(let data):
            return .requestBody(data)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .retrieveProfile:
            return .get
        case .updateProfile:
            return .put
        }
    }
}
