//
//  FetchMoviesUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import Foundation

final class FetchMoviesUseCase {

    enum FetchMoviesError: Error {
        case maxPagesReached
    }

    enum Page {
        case first
        case next
    }

    private var pageCount = 1
    private var currentPage = 1

    private let movieRepository: MovieRepositoryProtocol
    private let getDetailsFromMovies: GetDetailsFromMoviesUseCase

    init(movieRepository: MovieRepositoryProtocol, getDetailsFromMovies: GetDetailsFromMoviesUseCase) {
        self.movieRepository = movieRepository
        self.getDetailsFromMovies = getDetailsFromMovies
    }

    func execute(_ page: Page) async throws -> [MovieDetails] {
        currentPage = page == .first ? 1 : currentPage + 1

        guard currentPage <= pageCount else { throw FetchMoviesError.maxPagesReached }

        let moviesPagedList = try await movieRepository.getMoviesPagedList(page: currentPage)
        self.pageCount = moviesPagedList.pageInfo.pageCount
        let movieList = moviesPagedList.movies

        let movieDetailsList = getDetailsFromMovies.execute(movieList)
        return movieDetailsList
    }
}
