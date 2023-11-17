//
//  UserShortObject.swift
//  Movies
//
//  Created by Ivan Semenov on 17.11.2023.
//

import Foundation
import RealmSwift

final class UserShortObject: Object {
    @Persisted(primaryKey: true) var userId: String
    @Persisted var nickName: String?
    @Persisted var avatar: String?

    convenience init(_ userShort: UserShort) {
        self.init()

        userId = userShort.userId
        nickName = userShort.nickName
        avatar = userShort.avatar
    }

    func toDomain() -> UserShort {
        UserShort(userId: userId, nickName: nickName, avatar: avatar)
    }
}
