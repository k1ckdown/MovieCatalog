//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepository {

    private let networkService: MovieNetworkService

    init(networkService: MovieNetworkService) {
        self.networkService = networkService
    }
}

extension MovieRepository: MovieRepositoryProtocol {

    func getMovie(id: String) async throws -> Movie {
        let movie = try await networkService.fetchMovie(id: id)
        return movie.toDomain()
    }

    func getMovieShortList(page: Int) async throws -> [MovieShort] {
        let movies = try await networkService.fetchShortMovies(page: page)
        return movies.movies.map { $0.toDomain() }
    }
}
