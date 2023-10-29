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

    func getMovieList(page: Int) async throws -> [Movie] {
        let movies = try await networkService.fetchMovies(page: page)
        return movies.movies.map { $0.toDomain() }
    }
    
    func getMovieDetails(id: String) async throws -> MovieDetails {
        let movie = try await networkService.fetchDetails(id: id)
        return movie.toDomain()
    }
}
