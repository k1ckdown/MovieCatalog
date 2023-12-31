//
//  MovieRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

final class MovieRemoteDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension MovieRemoteDataSource {

    func fetchMovie(id: String) async throws -> MovieDTO {
        let config = MovieNetworkConfig.detailsById(id)
        return try await networkService.request(with: config)
    }

    func fetchMoviesPagedList(page: Int) async throws -> MoviesPagedResponse {
        let config = MovieNetworkConfig.listByPage(page)
        return try await networkService.request(with: config)
    }

    func addFavoriteMovie(movieId: String) async throws {
        let config = FavoriteMoviesNetworkConfig.add(movieId: movieId)
        try await networkService.request(with: config, useToken: true)
    }

    func deleteFavoriteMovie(movieId: String) async throws {
        let config = FavoriteMoviesNetworkConfig.delete(movieId: movieId)
        try await networkService.request(with: config, useToken: true)
    }

    func fetchFavoriteMovies() async throws -> MoviesResponse {
        let config = FavoriteMoviesNetworkConfig.list
        return try await networkService.request(with: config, useToken: true)
    }
}
