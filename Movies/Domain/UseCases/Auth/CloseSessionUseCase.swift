//
//  CloseSessionUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class CloseSessionUseCase {

    private let movieRepository: MovieRepository
    private let profileRepository: ProfileRepository

    init(
        movieRepository: MovieRepository,
        profileRepository: ProfileRepository
    ) {
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
    }

    func execute() async throws {
        await profileRepository.deleteProfile()
        try await movieRepository.deleteAllMovies()
    }
}
