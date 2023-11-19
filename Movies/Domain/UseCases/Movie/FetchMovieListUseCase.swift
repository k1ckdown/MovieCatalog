//
//  FetchMovieListUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMovieListUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(page: Page?) async throws -> [Movie] {
        return try await movieRepository.getMovieList(page: page)
    }
}
