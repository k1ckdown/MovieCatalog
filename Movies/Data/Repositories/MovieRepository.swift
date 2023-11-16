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

    private var loadedMovies = [Movie]()
    private var pagination = Pagination()

    private var isFavoritesLoaded = false
    private var favoriteMovies: [Movie] {
        loadedMovies.filter { $0.isFavorite }
    }

    private let remoteDataSource: MovieRemoteDataSource

    init(remoteDataSource: MovieRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension MovieRepository: MovieRepositoryProtocol {

    func addFavoriteMovie(_ id: String, token: String) async throws {
        try await remoteDataSource.addFavoriteMovie(token: token, movieId: id)
        if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
            loadedMovies[index].isFavorite = true
        }
    }

    func deleteFavoriteMovie(_ id: String, token: String) async throws {
        try await remoteDataSource.deleteFavoriteMovie(token: token, movieId: id)
        if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
            loadedMovies[index].isFavorite = false
        }
    }

    func getFavoriteMovies(token: String) async throws -> [Movie] {
        if isFavoritesLoaded == false {
            try await loadFavoriteMovies(token: token)
            isFavoritesLoaded = true
        }

        return favoriteMovies
    }

    func getMovie(id: String) async throws -> Movie {
        let movieDto = try await remoteDataSource.fetchMovie(id: id)
        var movie = movieDto.toDomain()

        if let index = loadedMovies.firstIndex(where: { $0.id == movie.id }) {
            movie.isPaged = loadedMovies[index].isPaged
            movie.isFavorite = loadedMovies[index].isFavorite
            loadedMovies[index] = movie
        }

        return movie
    }

    func getMovieList(page: Page?) async throws -> [Movie] {
        guard let page else {
            return loadedMovies.filter { $0.isPaged }
        }

        pagination.page = page

        guard pagination.isLimitReached == false else {
            throw MovieRepositoryError.maxPagesReached
        }

        if case .first = page {
            loadedMovies = []
            isFavoritesLoaded = false
        }

        let moviesPagedListDto = try await remoteDataSource.fetchShortMovies(
            page: pagination.currentPage
        )

        if pagination.pageCount == nil {
            pagination.pageCount = moviesPagedListDto.pageInfo.pageCount
        }

        let movieShortIds = moviesPagedListDto.movies.map { $0.toDomain().id }
        return try await loadMovieList(movieShortIds)
    }
}

private extension MovieRepository {

    func loadFavoriteMovies(token: String) async throws {
        let moviesResponse = try await remoteDataSource.fetchFavoriteMovies(token: token)
        let movieShortIds = moviesResponse.movies.map { $0.toDomain().id }

        try await withThrowingTaskGroup(of: Movie.self) { taskGroup in
            for id in movieShortIds {
                if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
                    loadedMovies[index].isFavorite = true
                } else {
                    taskGroup.addTask {
                        try await self.getMovie(id: id)
                    }
                }
            }

            for try await var movie in taskGroup {
                movie.isPaged = false
                movie.isFavorite = true
                loadedMovies.append(movie)
            }
        }
    }

    func loadMovieList(_ identifiers: [String]) async throws -> [Movie] {
        try await withThrowingTaskGroup(
            of: Movie.self,
            returning: [Movie].self) { taskGroup in
                var movies = [Movie]()

                for id in identifiers {
                    if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
                        loadedMovies[index].isPaged = true
                        movies.append(loadedMovies[index])
                    } else {
                        taskGroup.addTask {
                            try await self.getMovie(id: id)
                        }
                    }
                }

                return try await taskGroup.reduce(into: movies) { partialResult, movie in
                    loadedMovies.append(movie)
                    partialResult.append(movie)
                }
            }
    }
}
