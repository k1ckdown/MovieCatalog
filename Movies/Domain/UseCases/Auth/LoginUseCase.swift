//
//  LoginUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class LoginUseCase {

    private let authRepository: AuthRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        authRepository: AuthRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.authRepository = authRepository
        self.keychainRepository = keychainRepository
    }

    func execute(username: String, password: String) async throws {
        let credentials = LoginCredentials(username: username, password: password)
        let token = try await authRepository.logIn(credentials: credentials)
        try keychainRepository.saveToken(token)
    }
}
