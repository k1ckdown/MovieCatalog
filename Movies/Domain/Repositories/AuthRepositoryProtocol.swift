//
//  AuthRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol AuthRepositoryProtocol {
    func logOut(token: String) async throws
    func register(_ user: UserRegister) async throws -> String
    func logIn(username: String, password: String) async throws -> String
}
