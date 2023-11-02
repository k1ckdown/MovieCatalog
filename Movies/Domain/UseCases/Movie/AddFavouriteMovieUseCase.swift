//
//  AddFavouriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class AddFavouriteMovieUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let secureStorage: SecureStorageProtocol

    init(movieRepository: MovieRepositoryProtocol, secureStorage: SecureStorageProtocol) {
        self.movieRepository = movieRepository
        self.secureStorage = secureStorage
    }

    func execute(id: String) async throws {
        let token = try secureStorage.retrieveToken()
        try await movieRepository.addFavouriteMovie(id, token: token)
    }
}
