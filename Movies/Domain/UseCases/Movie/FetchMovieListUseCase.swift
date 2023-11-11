//
//  FetchMovieListUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMovieListUseCase {

    private let movieRepository: MovieRepositoryProtocol
    private let makeMovieDetailsUseCase: MakeMovieDetailsUseCase

    init(
        movieRepository: MovieRepositoryProtocol,
        makeMovieDetailsUseCase: MakeMovieDetailsUseCase
    ) {
        self.movieRepository = movieRepository
        self.makeMovieDetailsUseCase = makeMovieDetailsUseCase
    }

    func execute(_ page: Page) async throws -> [MovieDetails] {
        let movieList = try await movieRepository.getMovieList(page: page)
        let movieDetailsList = try await makeMovieDetailsUseCase.execute(movieList)

        return movieDetailsList
    }
}
