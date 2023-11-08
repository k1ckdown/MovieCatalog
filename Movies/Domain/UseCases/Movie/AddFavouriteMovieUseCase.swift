//
//  AddFavouriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class AddFavouriteMovieUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol, keychainRepository: KeychainRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
    }

    func execute(id: String) async throws {
        let token = try keychainRepository.retrieveToken()
        try await movieRepository.addFavouriteMovie(id, token: token)
    }
}
