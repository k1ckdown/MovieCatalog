//
//  NetworkServiceProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

protocol MovieNetworkService {
    func fetchMovies(page: Int) async throws -> MoviesResponse
    func fetchDetails(id: String) async throws -> MovieDetailsDTO
}

protocol UserNetworkService {
    func fetchProfile(token: String) async throws -> ProfileDTO
    func updateProfile(token: String, profile: ProfileDTO) async throws
}

protocol AuthNetworkService {
    func logout(token: String) async throws -> LogoutResponse
    func register(user: UserRegisterDTO) async throws -> TokenInfo
    func login(credentials: LoginCredentials) async throws -> TokenInfo
}
