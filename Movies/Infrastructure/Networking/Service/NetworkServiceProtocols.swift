//
//  NetworkServiceProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

protocol MovieNetworkService {
    func fetchMovies(page: Int) async throws -> MoviesResponse
    func fetchDetails(id: String) async throws -> MovieDetailsDTO
}
