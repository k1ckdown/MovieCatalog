//
//  DeleteFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 10.11.2023.
//

import Foundation

final class DeleteFavoriteMovieUseCase {
    
    private let closeSessionUseCase: CloseSessionUseCase
    private let movieRepository: MovieRepository
    
    init(
        closeSessionUseCase: CloseSessionUseCase,
        movieRepository: MovieRepository
    ) {
        self.closeSessionUseCase = closeSessionUseCase
        self.movieRepository = movieRepository
    }
    
    func execute(_ movieId: String) async throws {
        do {
            try await movieRepository.deleteFavoriteMovie(id: movieId)
        } catch {
            if error as? AuthError == .unauthorized {
                try await closeSessionUseCase.execute()
            }
            
            throw error
        }
    }
}
