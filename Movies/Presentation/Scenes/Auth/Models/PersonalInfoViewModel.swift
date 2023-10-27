//
//  PersonalInfoViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import Foundation

struct PersonalInfoViewModel: Equatable, Hashable {
    let userName: String
    let name: String
    let email: String
    let birthDate: Date
    let gender: Gender
}
