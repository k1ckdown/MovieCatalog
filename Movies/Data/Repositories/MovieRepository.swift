//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepository {

    private var favoriteMovies = [Movie]()
    private let movieRemoteDataSource: MovieRemoteDataSource

    init(movieRemoteDataSource: MovieRemoteDataSource) {
        self.movieRemoteDataSource = movieRemoteDataSource
    }
}

extension MovieRepository: MovieRepositoryProtocol {

    func addFavoriteMovie(_ id: String, token: String) async throws {
        try await movieRemoteDataSource.addFavoriteMovie(token: token, movieId: id)
    }

    func deleteFavoriteMovie(_ id: String, token: String) async throws {
        try await movieRemoteDataSource.deleteFavoriteMovie(token: token, movieId: id)
    }

    func getFavoriteMovies(token: String) async throws -> [Movie] {
        let moviesResponse = try await movieRemoteDataSource.fetchFavoriteMovies(token: token)
        let movieShortList = moviesResponse.movies.map { $0.toDomain() }

        let movies = try await getMovieList(movieShortList)
        favoriteMovies = movies

        return movies
    }

    func getMoviesPagedList(page: Int) async throws -> MoviesPaged {
        let moviesPagedListDto = try await movieRemoteDataSource.fetchShortMovies(page: page)

        let pageInfo = moviesPagedListDto.pageInfo.toDomain()
        let movieShorts = moviesPagedListDto.movies.map { $0.toDomain() }

        let movies = try await getMovieList(movieShorts)
        let moviesPagedList = MoviesPaged(movies: movies, pageInfo: pageInfo)

        return moviesPagedList
    }
}

private extension MovieRepository {

    func getMovie(id: String) async throws -> Movie {
        let movieDto = try await movieRemoteDataSource.fetchMovie(id: id)
        let isFavorite = favoriteMovies.contains(where: { $0.id == movieDto.id })

        return movieDto.toDomain(isFavorite: isFavorite)
    }

    func getMovieList(_ movieShorts: [MovieShort]) async throws -> [Movie] {
        return try await withThrowingTaskGroup(
            of: Movie.self,
            returning: [Movie].self
        ) { taskGroup in
            for movieShort in movieShorts {
                taskGroup.addTask {
                    try await self.getMovie(id: movieShort.id)
                }
            }

            return try await taskGroup.reduce(into: [Movie]()) { partialResult, movie in
                partialResult.append(movie)
            }
        }
    }
}
