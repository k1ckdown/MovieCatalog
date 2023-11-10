//
//  FetchFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FetchFavoriteMoviesUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol
    private let closeSessionUseCase: CloseSessionUseCase
    private let getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        closeSessionUseCase: CloseSessionUseCase,
        getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase
    ) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
        self.closeSessionUseCase = closeSessionUseCase
        self.getDetailsFromMoviesUseCase = getDetailsFromMoviesUseCase
    }
    
    func execute() async throws -> [MovieDetails] {
        let token = try keychainRepository.retrieveToken()

        do {
            let movieList = try await movieRepository.getFavoriteMovies(token: token)
            let movieDetailsList = getDetailsFromMoviesUseCase.execute(movieList)
            return movieDetailsList
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
