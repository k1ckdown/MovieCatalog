//
//  FetchFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FetchFavoriteMoviesUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute() async throws -> [Movie] {
        return try await movieRepository.getFavoriteMovies()
    }
}
