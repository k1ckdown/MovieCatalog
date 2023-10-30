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

    func getMoviesPagedList(page: Int) async throws -> MoviesPaged {
        let moviesPagedList = try await networkService.fetchShortMovies(page: page)
        return moviesPagedList.toDomain()
    }
}
