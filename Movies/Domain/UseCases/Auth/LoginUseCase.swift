//
//  LoginUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class LoginUseCase {
    
    private let networkService: AuthNetworkService
    private let secureStorage: SecureStorageProtocol

    init(networkService: AuthNetworkService, secureStorage: SecureStorageProtocol) {
        self.networkService = networkService
        self.secureStorage = secureStorage
    }

    func execute(username: String, password: String) async throws {
        let credentials = LoginCredentials(username: username, password: password)
        let tokenInfo = try await networkService.login(credentials: credentials)
        try secureStorage.saveToken(tokenInfo.token)
    }
}
