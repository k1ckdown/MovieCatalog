//
//  Profile.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

struct Profile {
    let id: String
    let nickName: String
    let email: String
    let avatarLink: String
    let name: String
    let birthDate: Date
    let gender: Gender
}

extension Profile {
    static let mock = Profile(
        id: "id",
        nickName: "User",
        email: "email@gmail.com",
        avatarLink: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg.freepik.com%2Ffree-vector%2Fbusinessman-character-avatar-isolated_24877-60111.jpg%3Fsize%3D338%26ext%3Djpg%26ga%3DGA1.1.386372595.1698278400%26semt%3Dais&tbnid=5r2gsiMQhMPg3M&vet=10CAcQMyhrahcKEwjgnoCZxpmCAxUAAAAAHQAAAAAQCA..i&imgrefurl=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Favatar-placeholder&docid=0oL9FmONrCnhMM&w=338&h=338&q=avatar%20placehodler&client=safari&ved=0CAcQMyhrahcKEwjgnoCZxpmCAxUAAAAAHQAAAAAQCA",
        name: "Ivan",
        birthDate: Date.now,
        gender: .male
    )
}
