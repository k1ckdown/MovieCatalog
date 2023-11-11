//
//  FetchMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

final class FetchMovieUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let makeMovieDetailsUseCase: MakeMovieDetailsUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        makeMovieDetailsUseCase: MakeMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.makeMovieDetailsUseCase = makeMovieDetailsUseCase
    }

    func execute(movieId: String) async throws -> MovieDetails {
        let movie = try await movieRepository.getMovie(id: movieId)
        let movieDetails = try await makeMovieDetailsUseCase.execute([movie])

        return movieDetails[0]
    }
}
