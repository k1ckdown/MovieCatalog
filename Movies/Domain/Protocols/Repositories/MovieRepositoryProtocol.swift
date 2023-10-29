//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovie(id: String) async throws -> Movie
    func getMovieShortList(page: Int) async throws -> [MovieShort]
}
