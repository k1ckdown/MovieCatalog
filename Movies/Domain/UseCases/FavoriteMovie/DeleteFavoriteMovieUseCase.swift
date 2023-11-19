//
//  DeleteFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 10.11.2023.
//

import Foundation

final class DeleteFavoriteMovieUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(_ movieId: String) async throws {
        try await movieRepository.deleteFavoriteMovie(id: movieId)
    }
}
