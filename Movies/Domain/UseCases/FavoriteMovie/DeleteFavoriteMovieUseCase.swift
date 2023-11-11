//
//  DeleteFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 10.11.2023.
//

import Foundation

final class DeleteFavoriteMovieUseCase {

    private let closeSessionUseCase: CloseSessionUseCase
    private let movieRepository: MovieRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        closeSessionUseCase: CloseSessionUseCase,
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.closeSessionUseCase = closeSessionUseCase
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
    }

    func execute(_ movieId: String) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await movieRepository.deleteFavoriteMovie(movieId, token: token)
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
