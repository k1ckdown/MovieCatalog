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
    private let updateProfileUseCase: UpdateProfileUseCase
    private let validateEmailUseCase: ValidateEmailUseCase

    init(
        getProfileUseCase: GetProfileUseCase,
        updateProfileUseCase: UpdateProfileUseCase,
        validateEmailUseCase: ValidateEmailUseCase
    ) {
        self.state = .init()
        self.getProfileUseCase = getProfileUseCase
        self.updateProfileUseCase = updateProfileUseCase
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
        case .onAlertPresented(let isPresented):
            state.isAlertPresenting = isPresented
        }

        checkDataIsChange()
    }
}

private extension ProfileViewModel {

    func emailUpdated(_ email: String) {
        state.email = email

        do {
            try validateEmailUseCase.execute(email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func retrieveProfile() async {
        do {
            let profile = try await getProfileUseCase.execute()
            self.profile = profile
            handleProfileData(profile)
        } catch {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
        }
    }

    func handleProfileData(_ profile: Profile) {
        state.username = profile.nickName
        state.email = profile.email
        state.avatarLink = profile.avatarLink
        state.name = profile.name
        state.gender = profile.gender
        state.birthdate = profile.birthDate
    }

    func updateProfile() async {
        guard let id = profile?.id else { return }

        let updatedProfile = Profile(
            id: id,
            nickName: state.username,
            email: state.email,
            avatarLink: state.avatarLink,
            name: state.name,
            birthDate: state.birthdate,
            gender: state.gender
        )

        do {
            try await updateProfileUseCase.execute(updatedProfile)
            profile = updatedProfile
        } catch {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
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
