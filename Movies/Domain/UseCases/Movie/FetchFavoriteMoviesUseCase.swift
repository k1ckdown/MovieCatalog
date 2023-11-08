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
    private let getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase
    ) {
        self.keychainRepository = keychainRepository
        self.movieRepository = movieRepository
        self.getDetailsFromMoviesUseCase = getDetailsFromMoviesUseCase
    }

    func execute() async throws -> [MovieDetails] {
        let token = try keychainRepository.retrieveToken()
        let movieShortList = try await movieRepository.getFavoriteMovies(token: token)
        let movieDetailsList = try await getDetailsFromMoviesUseCase.execute(movieShortList)

        return movieDetailsList
    }
}
