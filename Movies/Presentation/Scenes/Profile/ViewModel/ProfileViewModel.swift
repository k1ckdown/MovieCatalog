//
//  ProfileViewModel.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

final class ProfileViewModel: ViewModel {

    @Published private(set) var state: ProfileViewState

    private var profile: Profile?
    private let getProfileUseCase: GetProfileUseCase
    private let validateEmailUseCase: ValidateEmailUseCase

    init(getProfileUseCase: GetProfileUseCase, validateEmailUseCase: ValidateEmailUseCase) {
        self.state = .init()
        self.getProfileUseCase = getProfileUseCase
        self.validateEmailUseCase = validateEmailUseCase
    }

    func handle(_ event: ProfileViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveProfile() }

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

    func retrieveProfile() async {
        do {
            profile = try await getProfileUseCase.execute()
            state.loadError = nil
        } catch {
            state.loadError = error.localizedDescription
        }
    }

    func emailUpdated(_ email: String) {
        state.email = email

        do {
            try validateEmailUseCase.execute(email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func checkDataIsChange() {
        guard let profile = profile else { return }

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
