//
//  CloseSessionUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class CloseSessionUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let profileRepository: ProfileRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        movieRepository: MovieRepositoryProtocol,
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
    }

    func execute() async throws {
        try keychainRepository.deleteToken()
        await profileRepository.deleteProfile()
        try await movieRepository.deleteAllMovies()
    }
}
