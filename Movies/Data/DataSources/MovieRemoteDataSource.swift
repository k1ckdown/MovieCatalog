//
//  MovieRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol MovieRemoteDataSource {
    func fetchMovie(id: String) async throws -> MovieDTO
    func fetchShortMovies(page: Int) async throws -> MoviesPagedResponse
    func addFavoriteMovie(token: String, movieId: String) async throws
    func deleteFavoriteMovie(token: String, movieId: String) async throws
    func fetchFavoriteMovies(token: String) async throws -> MoviesResponse
}
