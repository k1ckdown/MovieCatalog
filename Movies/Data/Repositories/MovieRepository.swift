//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepository {
    
    private let movieRemoteDataSource: MovieRemoteDataSource
    
    init(movieRemoteDataSource: MovieRemoteDataSource) {
        self.movieRemoteDataSource = movieRemoteDataSource
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func addFavoriteMovie(_ id: String, token: String) async throws {
        try await movieRemoteDataSource.addFavoriteMovie(token: token, movieId: id)
    }
    
    func getMovie(id: String) async throws -> Movie {
        let movie = try await movieRemoteDataSource.fetchMovie(id: id)
        return movie.toDomain()
    }
    
    func getMoviesPagedList(page: Int) async throws -> MoviesPaged {
        let moviesPagedList = try await movieRemoteDataSource.fetchShortMovies(page: page)
        return moviesPagedList.toDomain()
    }
    
    func getFavoriteMovies(token: String) async throws -> [MovieShort] {
        let moviesResponse = try await movieRemoteDataSource.fetchFavoriteMovies(token: token)
        let movies = moviesResponse.movies.map { $0.toDomain() }
        
        return movies
    }
}
