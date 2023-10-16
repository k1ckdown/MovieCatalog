//
//  HTTPMethod.swift
//  Movies
//
//  Created by Ivan Semenov on 15.10.2023.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem]? = nil)
    case post(Data?)
    case put(Data?)
    case delete

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
