//
//  ProfileRemoteDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 08.11.2023.
//

import Foundation

protocol ProfileRemoteDataSource {
    func fetchProfile(token: String) async throws -> ProfileDTO
    func updateProfile(token: String, profile: ProfileDTO) async throws
}
