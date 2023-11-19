//
//  ProfileRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

protocol ProfileRepository {
    func deleteProfile() async
    func getProfile() async throws -> Profile
    func updateProfile(_ profile: Profile) async throws
}
