//
//  RegisterUserUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class RegisterUserUseCase {

    private let secureStorage: SecureStorage
    private let networkService: AuthNetworkService

    init(secureStorage: SecureStorage, networkService: AuthNetworkService) {
        self.secureStorage = secureStorage
        self.networkService = networkService
    }

    func execute(_ user: UserRegister) async throws {
        let tokenInfo = try await networkService.register(user: user)
        try secureStorage.saveToken(tokenInfo.token)
    }
}
