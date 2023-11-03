//
//  FetchFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FetchFavoriteMoviesUseCase {

    private let secureStorage: SecureStorageProtocol
    private let movieRepository: MovieRepositoryProtocol
    private let getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase

    init(
        secureStorage: SecureStorageProtocol,
        movieRepository: MovieRepositoryProtocol,
        getDetailsFromMoviesUseCase: GetDetailsFromMoviesUseCase
    ) {
        self.secureStorage = secureStorage
        self.movieRepository = movieRepository
        self.getDetailsFromMoviesUseCase = getDetailsFromMoviesUseCase
    }

    func execute() async throws -> [MovieDetails] {
        let token = try secureStorage.retrieveToken()
        let movieShortList = try await movieRepository.getFavoriteMovies(token: token)
        let movieDetailsList = try await getDetailsFromMoviesUseCase.execute(movieShortList)

        return movieDetailsList
    }
}
