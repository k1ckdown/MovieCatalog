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

    init(movieRepository: MovieRepositoryProtocol, keychainRepository: KeychainRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
    }

    func execute(id: String) async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await movieRepository.addFavoriteMovie(id, token: token)
        } catch {
            if error as? AuthError == .unauthorized {
                try keychainRepository.deleteToken()
            }

            throw error
        }
    }
}
