//
//  AuthRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

final class AuthRepository {

    private let authDataSource: AuthDataSource

    init(authDataSource: AuthDataSource) {
        self.authDataSource = authDataSource
    }
}

extension AuthRepository: AuthRepositoryProtocol {

    func logOut(token: String) async throws {
        let _ = try await authDataSource.logOut(token: token)
    }

    func register(_ user: UserRegister) async throws -> String {
        let tokenInfo = try await authDataSource.register(user: user)
        return tokenInfo.token
    }

    func logIn(username: String, password: String) async throws -> String {
        let credentials = LoginCredentials(username: username, password: password)
        let tokenInfo = try await authDataSource.logIn(credentials: credentials)

        return tokenInfo.token
    }
}
