//
//  LoginUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class LoginUseCase {

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

    func execute(username: String, password: String) async throws {
        let token = try await authRepository.logIn(username: username, password: password)
        try secureStorage.saveToken(token)
        try await profileRepository.loadProfile(token: token)
    }
}
