//
//  FetchMovieListUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMovieListUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol
    private let makeMovieDetailsUseCase: MakeMovieDetailsUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol,
        makeMovieDetailsUseCase: MakeMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.keychainRepository = keychainRepository
        self.makeMovieDetailsUseCase = makeMovieDetailsUseCase
    }

    func execute(_ page: Page) async throws -> [MovieDetails] {
        let token = try keychainRepository.retrieveToken()
        _ = try await movieRepository.getFavoriteMovies(token: token)

        let movieList = try await movieRepository.getMovieList(page: page)
        let movieDetailsList = try await makeMovieDetailsUseCase.execute(movieList)

        return movieDetailsList
    }
}
