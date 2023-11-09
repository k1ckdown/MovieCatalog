//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovie(id: String) async throws -> Movie
    func getMoviesPagedList(page: Int) async throws -> MoviesPaged
    func getFavoriteMovies(token: String) async throws -> [MovieShort]
    func addFavouriteMovie(_ id: String, token: String) async throws
}