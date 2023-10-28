//
//  ProfileViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileViewModel: ViewModel {

    @Published private(set) var state: ProfileViewState
    

    init() {
        state = .init()
    }

    func handle(_ event: ProfileViewEvent) {
        switch event {
        case .onTapEdit:
            break

        case .onTapSave:
            break

        case .onTapLogOut:
            break

        case .emailChanged(let email):
            state.email = email

        case .avatarLinkChanged(let link):
            state.avatarLink = link

        case .nameChanged(let name):
            state.name = name

        case .genderChanged(let gender):
            state.gender = gender

        case .birthdateChanged(let date):
            state.birthdate = date
        }
    }
}
