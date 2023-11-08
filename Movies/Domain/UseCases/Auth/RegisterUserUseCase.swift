//
//  RegisterUserUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class RegisterUserUseCase {

    private let secureStorage: SecureStorageProtocol
    private let authRepository: AuthRepositoryProtocol
    private let profileRepository: ProfileRepositoryProtocol

    init(
        secureStorage: SecureStorageProtocol,
        authRepository: AuthRepositoryProtocol,
        profileRepository: ProfileRepositoryProtocol
    ) {
        self.secureStorage = secureStorage
        self.authRepository = authRepository
        self.profileRepository = profileRepository
    }

    func execute(_ user: UserRegister) async throws {
        let token = try await authRepository.register(user)
        try secureStorage.saveToken(token)
        try await profileRepository.loadProfile(token: token)
    }
}
