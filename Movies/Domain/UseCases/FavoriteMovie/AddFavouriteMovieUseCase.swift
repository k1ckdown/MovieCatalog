//
//  AddFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class AddFavoriteMovieUseCase {

    private let movieRepository: MovieRepository
    private let closeSessionUseCase: CloseSessionUseCase

    init(
        movieRepository: MovieRepository,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.movieRepository = movieRepository
        self.closeSessionUseCase = closeSessionUseCase
    }

    func execute(_ movieId: String) async throws {
        do {
            try await movieRepository.addFavoriteMovie(id: movieId)
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
