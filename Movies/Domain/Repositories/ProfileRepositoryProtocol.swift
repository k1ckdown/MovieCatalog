//
//  ProfileRepositoryProtocol.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

protocol ProfileRepositoryProtocol {
    func getProfileId() throws -> String
    func getProfile(token: String) async throws -> Profile
    func updateProfile(_ profile: Profile, token: String) async throws
}
