//
//  UserNetworkService.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

protocol UserNetworkService {
    func fetchProfile(token: String) async throws -> ProfileDTO
    func updateProfile(token: String, profile: Profile) async throws
}
