//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepository {
    typealias NetworkService = MovieNetworkService & FavoriteMoviesNetworkService

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension MovieRepository: MovieRepositoryProtocol {

    func addFavouriteMovie(_ id: String, token: String) async throws {
        try await networkService.addFavoriteMovie(token: token, movieId: id)
    }

    func getMovie(id: String) async throws -> Movie {
        let movie = try await networkService.fetchMovie(id: id)
        return movie.toDomain()
    }

    func getMoviesPagedList(page: Int) async throws -> MoviesPaged {
        let moviesPagedList = try await networkService.fetchShortMovies(page: page)
        return moviesPagedList.toDomain()
    }

    func getFavoriteMovies(token: String) async throws -> [MovieShort] {
        let moviesResponse = try await networkService.fetchFavoriteMovies(token: token)
        let movies = moviesResponse.movies.map { $0.toDomain() }
        
        return movies
    }
}
