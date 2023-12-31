//
//  ProfileDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct ProfileDTO: Codable {
    let id: String
    let nickName: String?
    let email: String
    let avatarLink: String?
    let name: String
    let birthDate: String
    let gender: GenderDTO

    func toDomain() -> Profile {
        .init(
            id: id,
            nickName: nickName ?? "",
            email: email,
            avatarLink: avatarLink ?? "",
            name: name,
            birthDate: DateFormatter.iso8601Full.date(from: birthDate) ?? .now,
            gender: gender == .male ? .male : .female
        )
    }
}
