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
    private let networkManager = NetworkManager()
}

// MARK: - UserRemoteDataSource

extension NetworkService: ProfileRemoteDataSource {

    func fetchProfile(token: String) async throws -> ProfileDTO {
        let config = UserNetworkConfig.retrieveProfile
        return try await request(with: config, token: token)
    }

    func updateProfile(token: String, profile: ProfileDTO) async throws {
        let data = try encode(profile)
        let config = UserNetworkConfig.updateProfile(data)

        try await request(with: config, token: token)
    }

}

// MARK: - ReviewRemoteDataSource

extension NetworkService: ReviewRemoteDataSource {

    func deleteReview(token: String, movieId: String, reviewId: String) async throws {
        let config = ReviewNetworkConfig.delete(movieId: movieId, reviewId: reviewId)
        try await request(with: config, token: token)
    }

    func addReview(token: String, movieId: String, review: ReviewModifyDTO) async throws {
        let data = try encode(review)
        let config = ReviewNetworkConfig.add(movieId: movieId, review: data)

        try await request(with: config, token: token)
    }

    func updateReview(token: String, movieId: String, reviewId: String, review: ReviewModifyDTO) async throws {
        let data = try encode(review)
        let config = ReviewNetworkConfig.edit(movieId: movieId, reviewId: reviewId, review: data)

        try await request(with: config, token: token)
    }

}

// MARK: - MovieRemoteDataSource

extension NetworkService: MovieRemoteDataSource {

    func fetchMovie(id: String) async throws -> MovieDTO {
        let config = MovieNetworkConfig.detailsById(id)
        return try await request(with: config)
    }

    func fetchShortMovies(page: Int) async throws -> MoviesPagedResponse {
        let config = MovieNetworkConfig.listByPage(page)
        return try await request(with: config)
    }

    func addFavoriteMovie(token: String, movieId: String) async throws {
        let config = FavoriteMoviesNetworkConfig.add(movieId: movieId)
        try await request(with: config, token: token)
    }

    func deleteFavoriteMovie(token: String, movieId: String) async throws {
        let config = FavoriteMoviesNetworkConfig.delete(movieId: movieId)
        try await request(with: config, token: token)
    }

    func fetchFavoriteMovies(token: String) async throws -> MoviesResponse {
        let config = FavoriteMoviesNetworkConfig.list
        return try await request(with: config, token: token)
    }

}

// MARK: - AuthDataSource

extension NetworkService: AuthDataSource {

    func logOut(token: String) async throws -> LogoutResponseDTO {
        let config = AuthNetworkConfig.logout
        return try await request(with: config)
    }

    func logIn(credentials: LoginCredentials) async throws -> TokenInfo {
        let data = try encode(credentials)
        let config = AuthNetworkConfig.login(data)

        return try await request(with: config)
    }

    func register(user: UserRegister) async throws -> TokenInfo {
        let userDto = UserRegisterDTO(
            userName: user.userName,
            name: user.name,
            password: user.password,
            email: user.email,
            birthDate: user.birthDate,
            gender: user.gender == .female ? .female : .male
        )

        let data = try encode(userDto)
        let config = AuthNetworkConfig.register(data)

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

    func checkResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }

        guard
            (200...299).contains(httpResponse.statusCode)
        else {
            switch HTTPStatusCode(rawValue: httpResponse.statusCode) {
            case .unauthorized:
                throw AuthError.unauthorized
            default:
                throw NetworkError.invalidResponse
            }
        }
    }

    func request(with config: NetworkConfig, token: String? = nil) async throws {
        let (_, response) = try await networkManager.request(config: config, token: token)
        try checkResponse(response)
    }

    func request<Model: Decodable>(
        with config: NetworkConfig,
        token: String? = nil
    ) async throws -> Model {
        let (data, response) = try await networkManager.request(config: config, token: token)

        try checkResponse(response)
        guard let model = try? decoder.decode(Model.self, from: data) else {
            throw NetworkError.decodingError
        }

        return model
    }
}