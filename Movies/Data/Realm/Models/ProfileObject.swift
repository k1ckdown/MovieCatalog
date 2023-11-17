//
//  ProfileObject.swift
//  Movies
//
//  Created by Ivan Semenov on 16.11.2023.
//

import Foundation
import RealmSwift

final class ProfileObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var nickName: String
    @Persisted var email: String
    @Persisted var avatarLink: String
    @Persisted var name: String
    @Persisted var birthDate: Date
    @Persisted var gender: String

    convenience init(_ profile: Profile) {
        self.init()

        id = profile.id
        nickName = profile.nickName
        email = profile.email
        avatarLink = profile.avatarLink
        name = profile.name
        birthDate = profile.birthDate
        gender = profile.gender.rawValue
    }

    func toDomain() -> Profile {
        Profile(
            id: id,
            nickName: nickName,
            email: email,
            avatarLink: avatarLink,
            name: name,
            birthDate: birthDate,
            gender: Gender(rawValue: gender) ?? .male
        )
    }
}
