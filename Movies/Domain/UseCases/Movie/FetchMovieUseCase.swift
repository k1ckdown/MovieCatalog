//
//  FetchMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 11.11.2023.
//

import Foundation

final class FetchMovieUseCase {

    private let movieRepository: MovieRepository
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase

    init(
        movieRepository: MovieRepository,
        getMovieDetailsUseCase: GetMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func execute(movieId: String) async throws -> MovieDetails {
        try await movieRepository.getFavoriteMovies()

        let movie = try await movieRepository.getMovie(id: movieId)
        let movieDetails = try await getMovieDetailsUseCase.execute([movie])
        
        return movieDetails[0]
    }
}
