//
//  FetchMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

final class FetchMovieUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(movieId: String) async throws -> Movie {
        try await movieRepository.getFavoriteMovies()
        return try await movieRepository.getMovie(id: movieId)
    }
}
