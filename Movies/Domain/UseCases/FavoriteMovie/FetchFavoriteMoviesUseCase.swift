//
//  FetchFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class FetchFavoriteMoviesUseCase {

    private let movieRepository: MovieRepository
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase

    init(
        movieRepository: MovieRepository,
        getMovieDetailsUseCase: GetMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func execute() async throws -> [MovieDetails] {
        let movieList = try await movieRepository.getFavoriteMovies()
        let movieDetailsList = try await getMovieDetailsUseCase.execute(movieList)
        return movieDetailsList
    }
}
