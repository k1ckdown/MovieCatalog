//
//  LogoutUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class LogoutUseCase {

    private let authRepository: AuthRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        authRepository: AuthRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.authRepository = authRepository
        self.keychainRepository = keychainRepository
    }

    func execute() async throws {
        let token = try keychainRepository.retrieveToken()

        do {
            try await authRepository.logOut(token: token)
            try keychainRepository.deleteToken()
        } catch {
            if error as? AuthError == .unauthorized {
                try keychainRepository.deleteToken()
            }

            throw error
        }
    }
}
