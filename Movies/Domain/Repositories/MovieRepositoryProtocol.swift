//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovie(id: String) async throws -> Movie
    func getMovieList(page: Page?) async throws -> [Movie]

    @discardableResult
    func getFavoriteMovies(token: String) async throws -> [Movie]
    func addFavoriteMovie(_ id: String, token: String) async throws

    func deleteAllMovies() async throws
    func deleteFavoriteMovie(_ id: String, token: String) async throws
}
