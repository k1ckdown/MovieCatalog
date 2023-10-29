//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovieList(page: Int) async throws -> [Movie]
    func getMovieDetails(id: String) async throws -> MovieDetails
}
