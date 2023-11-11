//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepository {

    enum MovieRepositoryError: Error {
        case maxPagesReached
    }

    private var movies = [Movie]()
    private var pagination = Pagination()

    private var isFavoritesLoaded = false
    private var favoriteMovies = [Movie]()

    private let movieRemoteDataSource: MovieRemoteDataSource

    init(movieRemoteDataSource: MovieRemoteDataSource) {
        self.movieRemoteDataSource = movieRemoteDataSource
    }
}

extension MovieRepository: MovieRepositoryProtocol {

    func addFavoriteMovie(_ id: String, token: String) async throws {
        try await movieRemoteDataSource.addFavoriteMovie(token: token, movieId: id)
        if let movie = movies.first(where: { $0.id == id }) {
            favoriteMovies.append(movie)
        }
    }

    func deleteFavoriteMovie(_ id: String, token: String) async throws {
        try await movieRemoteDataSource.deleteFavoriteMovie(token: token, movieId: id)
        if let index = movies.firstIndex(where: { $0.id == id }) {
            favoriteMovies.remove(at: index)
        }
    }

    func getMovie(id: String) async throws -> Movie {
        let movieDto = try await movieRemoteDataSource.fetchMovie(id: id)
        return movieDto.toDomain()
    }

    func getFavoriteMovies(token: String) async throws -> [Movie] {
        if isFavoritesLoaded == false {
            try await loadFavoriteMovies(token: token)
            isFavoritesLoaded = true
        }

        return favoriteMovies
    }

    func getMovieList(page: Page) async throws -> [Movie] {
        pagination.page = page

        guard pagination.isLimitReached == false else {
            throw MovieRepositoryError.maxPagesReached
        }

        let moviesPagedListDto = try await movieRemoteDataSource.fetchShortMovies(
            page: pagination.currentPage
        )

        pagination.pageCount = moviesPagedListDto.pageInfo.pageCount
        let movieShorts = moviesPagedListDto.movies.map { $0.toDomain() }

        let movieList = try await getMovieList(from: movieShorts)
        movies.append(contentsOf: movieList)

        return movieList
    }
}

private extension MovieRepository {

    func loadFavoriteMovies(token: String) async throws {
        let moviesResponse = try await movieRemoteDataSource.fetchFavoriteMovies(token: token)
        let movieShortIds = moviesResponse.movies.map { $0.toDomain().id }

        for id in movieShortIds {
            if let index = movies.firstIndex(where: { $0.id == id }) {
                movies[index].isFavorite = true
            }
        }
    }

    func getMovieList(from movieShorts: [MovieShort]) async throws -> [Movie] {
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
