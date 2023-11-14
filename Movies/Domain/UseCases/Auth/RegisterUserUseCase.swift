//
//  RegisterUserUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class RegisterUserUseCase {

    private let authRepository: AuthRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        authRepository: AuthRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.authRepository = authRepository
        self.keychainRepository = keychainRepository
    }

    func execute(_ user: UserRegister) async throws {
        let token = try await authRepository.register(user: user)
        try keychainRepository.saveToken(token)
    }
}
