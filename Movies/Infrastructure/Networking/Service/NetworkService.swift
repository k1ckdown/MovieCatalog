//
//  NetworkService.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

final class NetworkService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let networkRouter = NetworkRouter()
}

// MARK: - MovieNetworkService

extension NetworkService: MovieNetworkService {
    func fetchMovies(page: Int) async throws -> MoviesResponse {
        let config = MovieNetworkConfig.listByPage(page)
        return try await request(with: config)
    }

    func fetchDetails(id: String) async throws -> MovieDetailsDTO {
        let config = MovieNetworkConfig.detailsById(id)
        return try await request(with: config)
    }
}

// MARK: - AuthNetworkService

extension NetworkService: AuthNetworkService {
    func logout(token: String) async throws -> LogoutResponse {
        let config = AuthNetworkConfig.logout
        return try await request(with: config)
    }

    func register(user: UserRegisterDTO) async throws -> TokenInfo {
        let data = try encode(user)
        let config = AuthNetworkConfig.register(data)

        return try await request(with: config)
    }

    func login(credentials: LoginCredentials) async throws -> TokenInfo {
        let data = try encode(credentials)
        let config = AuthNetworkConfig.login(data)

        return try await request(with: config)
    }
}

// MARK: - Private methods

private extension NetworkService {

    func encode<Value: Encodable>(_ value: Value) throws -> Data {
        guard let encoded = try? encoder.encode(value) else {
            throw NetworkError.encodingError
        }

        return encoded
    }

    func request<Model: Decodable>(with config: NetworkConfig) async throws -> Model {
        let (data, response) = try await networkRouter.request(config: config)

        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }

        guard let model = try? decoder.decode(Model.self, from: data) else {
            throw NetworkError.decodingError
        }

        return model
    }

}
