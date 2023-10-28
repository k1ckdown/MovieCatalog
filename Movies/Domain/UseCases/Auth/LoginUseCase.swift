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
    private let profileRepository: ProfileRepositoryProtocol
    
    init(
        networkService: AuthNetworkService,
        secureStorage: SecureStorageProtocol,
        profileRepository: ProfileRepositoryProtocol
    ) {
        self.networkService = networkService
        self.secureStorage = secureStorage
        self.profileRepository = profileRepository
    }
    
    func execute(username: String, password: String) async throws {
        let credentials = LoginCredentials(username: username, password: password)
        let tokenInfo = try await networkService.login(credentials: credentials)
        
        try secureStorage.saveToken(tokenInfo.token)
        try await profileRepository.loadProfile(token: tokenInfo.token)
    }
}
