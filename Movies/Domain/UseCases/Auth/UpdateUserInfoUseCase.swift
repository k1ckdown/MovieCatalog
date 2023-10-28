//
//  UpdateUserInfoUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class UpdateUserInfoUseCase {

    private let networkService: UserNetworkService
    private let secureStorage: SecureStorageProtocol

    init(networkService: UserNetworkService, secureStorage: SecureStorageProtocol) {
        self.networkService = networkService
        self.secureStorage = secureStorage
    }

    func execute(_ profile: Profile) async throws {
        let token = try secureStorage.retrieveToken()
        try await networkService.updateProfile(token: token, profile: profile)
    }
}
