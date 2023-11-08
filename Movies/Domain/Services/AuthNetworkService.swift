//
//  AuthNetworkService.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

protocol AuthNetworkService {
    func logout(token: String) async throws -> LogoutResponse
    func register(user: UserRegister) async throws -> TokenInfo
    func login(credentials: LoginCredentials) async throws -> TokenInfo
}
