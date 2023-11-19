//
//  FetchFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FetchFavoriteMoviesUseCase {

    private let movieRepository: MovieRepository
    private let closeSessionUseCase: CloseSessionUseCase
    private let makeMovieDetailsUseCase: MakeMovieDetailsUseCase

    init(
        movieRepository: MovieRepository,
        closeSessionUseCase: CloseSessionUseCase,
        makeMovieDetailsUseCase: MakeMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.closeSessionUseCase = closeSessionUseCase
        self.makeMovieDetailsUseCase = makeMovieDetailsUseCase
    }
    
    func execute() async throws -> [MovieDetails] {
        do {
            let movieList = try await movieRepository.getFavoriteMovies()
            let movieDetailsList = try await makeMovieDetailsUseCase.execute(movieList)
            return movieDetailsList
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }

            throw error
        }
    }
}
