//
//  RegisterUserUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class RegisterUserUseCase {

    private let authRepository: AuthRepositoryProtocol
    private let profileRepository: ProfileRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        authRepository: AuthRepositoryProtocol,
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.keychainRepository = keychainRepository
        self.authRepository = authRepository
        self.profileRepository = profileRepository
    }

    func execute(_ user: UserRegister) async throws {
        let token = try await authRepository.register(user)
        try keychainRepository.saveToken(token)
        try await profileRepository.loadProfile(token: token)
    }
}
