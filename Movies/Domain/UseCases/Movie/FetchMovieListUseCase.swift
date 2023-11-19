//
//  FetchMovieListUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMovieListUseCase {

    private let movieRepository: MovieRepository
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase

    init(
        movieRepository: MovieRepository,
        getMovieDetailsUseCase: GetMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func execute(page: Page?) async throws -> [MovieDetails] {
        let movieList = try await movieRepository.getMovieList(page: page)
        let movieDetailsList = try await getMovieDetailsUseCase.execute(movieList)

        return movieDetailsList
    }
}
