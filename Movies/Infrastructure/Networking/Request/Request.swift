//
//  Request.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

typealias HTTPHeaders = [String: String]

struct Request<Response> {
    let url: URL
    let method: HTTPMethod
    let headers = HTTPHeaders()
}

extension Request {
    func build() throws -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        switch method {
        case .put(let data), .post(let data):
            urlRequest.httpBody = data

        case .get(let queryItems):
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems

            guard let url = urlComponents?.url else { throw NetworkError.missingURL }
            urlRequest.url = url

        default: break
        }

        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.name

        return urlRequest
    }
}


