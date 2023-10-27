//
//  AuthService.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

final class AuthService {

    private let secureStorage: SecureStorage
    private let networkService: AuthNetworkService

    init(secureStorage: SecureStorage, networkService: AuthNetworkService) {
        self.secureStorage = secureStorage
        self.networkService = networkService
    }

    func register(_ user: UserRegister) async throws {
        let userDto = UserRegisterDTO(
            userName: user.userName,
            name: user.name,
            password: user.password,
            email: user.email,
            birthDate: user.birthDate,
            gender: user.gender == .female ? .female : .male
        )

        let tokenInfo = try await networkService.register(user: userDto)
        try secureStorage.saveToken(tokenInfo.token)
    }
}
