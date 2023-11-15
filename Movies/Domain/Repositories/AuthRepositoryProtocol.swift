//
//  AuthRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol AuthRepositoryProtocol {
    func logOut(_ token: String) async throws
    func register(user: UserRegister) async throws -> String
    func logIn(credentials: LoginCredentials) async throws -> String
}
