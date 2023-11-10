//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMoviesPagedList(page: Int) async throws -> MoviesPaged

    func getFavoriteMovies(token: String) async throws -> [Movie]
    func addFavoriteMovie(_ id: String, token: String) async throws
    func deleteFavoriteMovie(_ id: String, token: String) async throws
}
