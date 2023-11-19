//
//  MovieRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepository {
    func getMovie(id: String) async throws -> Movie
    func getMovieList(page: Page?) async throws -> [Movie]
    
    @discardableResult
    func getFavoriteMovies() async throws -> [Movie]
    func addFavoriteMovie(id: String) async throws
    
    func deleteAllMovies() async throws
    func deleteFavoriteMovie(id: String) async throws
}
