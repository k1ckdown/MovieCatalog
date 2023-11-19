//
//  MovieRepositoryImplementation.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class MovieRepositoryImplementation: @unchecked Sendable {

    enum MovieRepositoryError: Error {
        case maxPagesReached
    }

    private var loadedMovies = [Movie]()
    private var pagination = Pagination()

    private var isFavoritesLoaded = false
    private var favoriteMovies: [Movie] {
        loadedMovies.filter { $0.isFavorite }
    }

    private let localDataSource: MovieLocalDataSource
    private let remoteDataSource: MovieRemoteDataSource

    init(localDataSource: MovieLocalDataSource, remoteDataSource: MovieRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension MovieRepositoryImplementation: MovieRepository {

    func deleteAllMovies() async throws {
        loadedMovies = []
        isFavoritesLoaded = false
        await localDataSource.deleteAllMovies()
    }

    func addFavoriteMovie(id: String) async throws {
        do {
            try await remoteDataSource.addFavoriteMovie(movieId: id)
        } catch {
            try await handleUnauthorizedError(error)
        }

        if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
            loadedMovies[index].isFavorite = true
            await localDataSource.addMovie(MovieObject(loadedMovies[index]))
        }
    }

    func deleteFavoriteMovie(id: String) async throws {
        do {
            try await remoteDataSource.deleteFavoriteMovie(movieId: id)
        } catch {
            try await handleUnauthorizedError(error)
        }

        if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
            loadedMovies[index].isFavorite = false
            await localDataSource.deleteMovie(id: loadedMovies[index].id)
        }
    }

    func getMovie(id: String) async throws -> Movie {
        guard NetworkMonitor.shared.isConnected else {
            if let localMovie = await localDataSource.fetchMovie(id: id)?.toDomain() {
                return localMovie
            } else {
                throw NetworkError.noConnect
            }
        }

        let movieDto = try await remoteDataSource.fetchMovie(id: id)
        var movie = movieDto.toDomain()

        if let index = loadedMovies.firstIndex(where: { $0.id == movie.id }) {
            movie.isPaged = loadedMovies[index].isPaged
            movie.isFavorite = loadedMovies[index].isFavorite

            loadedMovies[index] = movie
            await localDataSource.addMovie(MovieObject(movie), update: true)
        }

        return movie
    }

    func getFavoriteMovies() async throws -> [Movie] {
        guard NetworkMonitor.shared.isConnected else {
            if let localMovies = await localDataSource.fetchMovieList() {
                return localMovies.map { $0.toDomain() }
            } else {
                throw NetworkError.noConnect
            }
        }

        if isFavoritesLoaded == false {
            do {
                try await loadFavoriteMovies()
                isFavoritesLoaded = true
            } catch {
                try await handleUnauthorizedError(error)
            }
        }

        return favoriteMovies
    }

    func getMovieList(page: Page?) async throws -> [Movie] {
        guard NetworkMonitor.shared.isConnected else { throw NetworkError.noConnect }
        guard let page else {
            guard loadedMovies.isEmpty == false else { throw NetworkError.requestFailed }
            return loadedMovies.filter { $0.isPaged }
        }

        pagination.page = page
        guard pagination.isLimitReached == false else {
            throw MovieRepositoryError.maxPagesReached
        }

        let moviesPagedListDto = try await remoteDataSource.fetchMoviesPagedList(
            page: pagination.currentPage
        )

        if pagination.pageCount == nil {
            pagination.pageCount = moviesPagedListDto.pageInfo.pageCount
        }

        let movieShortIds = moviesPagedListDto.movies.map { $0.toDomain().id }
        return try await loadMovieList(movieShortIds)
    }
}

private extension MovieRepositoryImplementation {

    func handleUnauthorizedError(_ error: Error) async throws {
        if error as? AuthError == .unauthorized {
            try await deleteAllMovies()
        }

        throw error
    }

    func loadMovieList(_ identifiers: [String]) async throws -> [Movie] {
        try await withThrowingTaskGroup(of: Movie.self, returning: [Movie].self) { taskGroup in
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

    func loadFavoriteMovies() async throws {
        let moviesResponse = try await remoteDataSource.fetchFavoriteMovies()
        let movieShortIds = moviesResponse.movies.map { $0.toDomain().id }

        try await withThrowingTaskGroup(of: Movie.self) { taskGroup in
            for id in movieShortIds {
                if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
                    loadedMovies[index].isFavorite = true
                    await localDataSource.addMovie(MovieObject(loadedMovies[index]))
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
                await localDataSource.addMovie(MovieObject(movie))
            }
        }
    }
}
