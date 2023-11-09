//
//  AddFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class AddFavoriteMovieUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol
    private let closeSessionUseCase: CloseSessionUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        closeSessionUseCase: CloseSessionUseCase
    ) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
        self.closeSessionUseCase = closeSessionUseCase
    }

    func execute(id: String) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await movieRepository.addFavoriteMovie(id, token: token)
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
