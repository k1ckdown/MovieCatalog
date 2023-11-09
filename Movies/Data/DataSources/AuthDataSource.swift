//
//  AuthDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol AuthDataSource {
    func register(user: UserRegister) async throws -> TokenInfo
    func logOut(token: String) async throws -> LogoutResponseDTO
    func logIn(credentials: LoginCredentials) async throws -> TokenInfo
}
