//
//  ProfileLocalDataSource.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//

import CoreData

final class ProfileLocalDataSource {

    private let context: NSManagedObjectContext

    init() {
        context = CoreDataManager.shared.context
    }
}

extension ProfileLocalDataSource {

    func getProfile() throws -> Profile? {
        guard
            let cdProfile = try context.fetch(CDProfile.fetchRequest()).first
        else { return nil }

        return Profile(
            id: cdProfile.id,
            nickName: cdProfile.nickname,
            email: cdProfile.email,
            avatarLink: cdProfile.avatarLink,
            name: cdProfile.name,
            birthDate: .now,
            gender: Gender(rawValue: cdProfile.gender) ?? .male
        )
    }

    func deleteProfile() throws {
        let fetchedProfiles = try context.fetch(CDProfile.fetchRequest())
        fetchedProfiles.forEach { context.delete($0) }
    }

    func saveProfile(_ profile: Profile) throws {
        guard
            let cdProfile = try context.fetch(CDProfile.fetchRequest()).first
        else { return }

        cdProfile.id = profile.id
        cdProfile.nickname = profile.nickName
        cdProfile.email = profile.email
        cdProfile.avatarLink = profile.avatarLink
        cdProfile.name = profile.name
        cdProfile.birthDate = profile.birthDate
        cdProfile.gender = profile.gender.rawValue

        try context.save()
    }
}
