//
//  UserRegisterDTO.swift
//  Movies
//
//  Created by Ivan Semenov on 16.10.2023.
//

import Foundation

struct UserRegisterDTO: Encodable {
    let userName: String
    let name: String
    let password: String
    let email: String
    let birthDate: String
    let gender: GenderDTO
}
