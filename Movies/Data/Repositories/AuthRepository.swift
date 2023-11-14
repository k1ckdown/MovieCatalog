//
//  AuthRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

final class AuthRepository {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension AuthRepository: AuthRepositoryProtocol {

    func logOut(_ token: String) async throws {
        let config = AuthNetworkConfig.logout
        try await networkService.request(with: config)
    }

    func logIn(credentials: LoginCredentials) async throws -> String {
        let data = try networkService.encode(credentials)
        let config = AuthNetworkConfig.login(data)
        let tokenInfo: TokenInfo = try await networkService.request(with: config)
        
        return tokenInfo.token
    }

    func register(user: UserRegister) async throws -> String {
        let userDto = UserRegisterDTO(
            userName: user.userName,
            name: user.name,
            password: user.password,
            email: user.email,
            birthDate: user.birthDate,
            gender: user.gender == .female ? .female : .male
        )

        let data = try networkService.encode(userDto)
        let config = AuthNetworkConfig.register(data)
        let tokenInfo: TokenInfo = try await networkService.request(with: config)

        return tokenInfo.token
    }
}
