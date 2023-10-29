//
//  FetchMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMoviesUseCase {

    enum Pagination {
        case firstPage
        case nextPage
    }

    private var currentPage = 1
    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    func execute(_ pagination: Pagination) async throws -> [MovieShort] {
        switch pagination {
        case .firstPage:
            currentPage = 1
        case .nextPage:
            currentPage += 1
        }

        return try await movieRepository.getMovieList(page: currentPage)
    }
}
