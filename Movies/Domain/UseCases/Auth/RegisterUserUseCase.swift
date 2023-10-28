//
//  RegisterUserUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class RegisterUserUseCase {

    private let networkService: AuthNetworkService
    private let secureStorage: SecureStorageProtocol

    init(networkService: AuthNetworkService, secureStorage: SecureStorageProtocol) {
        self.networkService = networkService
        self.secureStorage = secureStorage
    }

    func execute(_ user: UserRegister) async throws {
        let tokenInfo = try await networkService.register(user: user)
        try secureStorage.saveToken(tokenInfo.token)
    }
}