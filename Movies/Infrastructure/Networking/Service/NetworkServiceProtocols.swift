//
//  NetworkServiceProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

protocol MovieNetworkService {
    func fetchMovie(id: String) async throws -> MovieDTO
    func fetchShortMovies(page: Int) async throws -> MoviesPagedResponse
}

protocol UserNetworkService {
    func fetchProfile(token: String) async throws -> ProfileDTO
    func updateProfile(token: String, profile: ProfileDTO) async throws
}

protocol FavoriteMoviesNetworkService {
    func addFavoriteMovie(token: String, movieId: String) async throws
    func deleteFavoriteMovie(token: String, movieId: String) async throws
    func fetchFavoriteMovies(token: String) async throws -> MoviesResponse
}

protocol ReviewNetworkService {
    func deleteReview(token: String, movieId: String, reviewId: String) async throws
    func addReview(token: String, movieId: String, review: ReviewModifyDTO) async throws
    func updateReview(token: String, movieId: String, reviewId: String, review: ReviewModifyDTO) async throws
}

protocol AuthNetworkService {
    func logout(token: String) async throws -> LogoutResponseDTO
    func register(user: UserRegister) async throws -> TokenInfo
    func login(credentials: LoginCredentials) async throws -> TokenInfo
}
