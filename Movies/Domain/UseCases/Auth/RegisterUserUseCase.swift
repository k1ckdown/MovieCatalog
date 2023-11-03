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
    
    func execute(_ user: UserRegister) async throws {
        let tokenInfo = try await networkService.register(user: user)
        
        try secureStorage.saveToken(tokenInfo.token)
        try await profileRepository.loadProfile(token: tokenInfo.token)
    }
}
