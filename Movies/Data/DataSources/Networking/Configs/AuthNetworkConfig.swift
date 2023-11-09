//
//  AuthNetworkConfig.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

enum AuthNetworkConfig: NetworkConfig {
    case logout
    case login(Data)
    case register(Data)

    var path: String {
        "account/"
    }

    var endPoint: String {
        switch self {
        case .login:
            return "login"
        case .logout:
            return "logout"
        case .register:
            return "register"
        }
    }

    var task: HTTPTask {
        switch self {
        case .logout:
            return .request
        case .login(let data), .register(let data):
            return .requestBody(data)
        }
    }

    var method: HTTPMethod {
        return .post
    }
}
