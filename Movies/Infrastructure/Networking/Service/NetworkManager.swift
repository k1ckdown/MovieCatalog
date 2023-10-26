//
//  NetworkManager.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct NetworkManager {

    private enum Constants {
        static let movieBaseUrl = "https://react-midterm.kreosoft.space/api/"
    }

    func request(config: NetworkConfig, token: String?) async throws -> (Data, URLResponse) {
        let urlRequest = try buildRequest(with: config, token: token)
        return try await URLSession.shared.data(for: urlRequest)
    }

}

private extension NetworkManager {

    func buildRequest(with config: NetworkConfig, token: String?) throws -> URLRequest {
        let urlString = Constants.movieBaseUrl + config.path + config.endPoint
        guard let url = URL(string: urlString) else { throw NetworkError.missingURL }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        switch config.task {
        case .requestBody(let data):
            request.httpBody = data

        case .requestUrlParameters(let parameters):
            try URLParameterEncoder().encode(urlRequest: &request, with: parameters)

        default: break
        }

        request.httpMethod = config.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

}
