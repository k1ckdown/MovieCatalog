//
//  ProfileRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

protocol ProfileRepositoryProtocol {
    func getProfile() async throws -> Profile
    func loadProfile(token: String) async throws
    func updateProfile(_ profile: Profile, token: String) async throws
}
