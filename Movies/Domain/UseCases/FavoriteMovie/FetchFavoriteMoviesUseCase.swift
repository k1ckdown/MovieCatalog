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
    private let makeMovieDetailsUseCase: MakeMovieDetailsUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        closeSessionUseCase: CloseSessionUseCase,
        makeMovieDetailsUseCase: MakeMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
        self.closeSessionUseCase = closeSessionUseCase
        self.makeMovieDetailsUseCase = makeMovieDetailsUseCase
    }
    
    func execute() async throws -> [MovieDetails] {
        let token = try keychainRepository.retrieveToken()

        do {
            let movieList = try await movieRepository.getFavoriteMovies(token: token)
            let movieDetailsList = try await makeMovieDetailsUseCase.execute(movieList)
            return movieDetailsList
        } catch {
            if error as? AuthError == .unauthorized {
                try closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
