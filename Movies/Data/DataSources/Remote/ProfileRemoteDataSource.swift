//
//  ProfileRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

final class ProfileRemoteDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ProfileRemoteDataSource {

    func fetchProfile(token: String) async throws -> ProfileDTO {
        let config = UserNetworkConfig.retrieveProfile
        return try await networkService.request(with: config, token: token)
    }

    func updateProfile(token: String, profile: ProfileDTO) async throws {
        let data = try networkService.encode(profile)
        let config = UserNetworkConfig.updateProfile(data)

        try await networkService.request(with: config, token: token)
    }
}
