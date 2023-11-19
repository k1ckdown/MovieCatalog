//
//  AddFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class AddFavoriteMovieUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(_ movieId: String) async throws {
        try await movieRepository.addFavoriteMovie(id: movieId)
    }
}
