//
//  ProfileViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileViewModel: ViewModel {

    @Published private(set) var state: ProfileViewState

    private let validateEmailUseCase: ValidateEmailUseCase
    private let profile = Profile.mock

    init(validateEmailUseCase: ValidateEmailUseCase = .init()) {
        self.validateEmailUseCase = validateEmailUseCase
        state = .init(
            username: profile.nickName,
            email: profile.email,
            avatarLink: profile.avatarLink,
            name: profile.name,
            gender: profile.gender,
            birthdate: profile.birthDate
        )
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
            emailUpdated(email)

        case .avatarLinkChanged(let link):
            state.avatarLink = link

        case .nameChanged(let name):
            state.name = name

        case .genderChanged(let gender):
            state.gender = gender

        case .birthdateChanged(let date):
            state.birthdate = date
        }

        checkDataIsChange()
    }
}

private extension ProfileViewModel {

    func emailUpdated(_ email: String) {
        state.email = email
        state.isDataChanged = email != profile.email

        do {
            try validateEmailUseCase.execute(email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func checkDataIsChange() {
        let isNameChanged = state.name != profile.name
        let isEmailChanged = state.email != profile.email
        let isGenderChanged = state.gender != profile.gender
        let isAvatarLinkChanged = state.avatarLink != profile.avatarLink
        let isBirthdateChanged = !Calendar.current.isDate(
            state.birthdate,
            equalTo: profile.birthDate,
            toGranularity: .day
        )

        state.isDataChanged = isEmailChanged || isAvatarLinkChanged ||
        isNameChanged || isGenderChanged || isBirthdateChanged
    }
}
