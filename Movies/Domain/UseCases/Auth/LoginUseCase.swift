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
        let token = try await authRepository.logIn(username: username, password: password)
        try keychainRepository.saveToken(token)
    }
}
