//
//  UserShortDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct UserShortDTO: Decodable {
    let userId: String
    let nickName: String?
    let avatar: String?

    func toDomain() -> UserShort {
        .init(userId: userId, nickName: nickName, avatar: avatar)
    }
}
