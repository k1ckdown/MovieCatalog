//
//  PersonalInfoRegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct PersonalInfoRegistrationView: View {

    @StateObject private var viewModel: PersonalInfoRegistrationViewModel

    init(viewModel: PersonalInfoRegistrationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AuthView(
            style: .personalInfo,
            isFormButtonDisabled: viewModel.state.isContinueDisabled,
            screenTitle: LocalizedKey.Auth.Label.registration,
            formButtonTitle: LocalizedKey.Auth.Action.continue,
            calloutText: LocalizedKey.Auth.Callout.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKey.Auth.Callout.logInToAccount
        ) {
            Group {
                TextField("", text: name)
                    .smallLabeled(LocalizedKey.Profile.name)
                    .formBorderedTextFieldStyle()

                GenderSegmentedPicker(selection: gender)
                    .smallLabeled(LocalizedKey.Profile.gender)

                TextField("", text: username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .formErrorableItem(
                        message: viewModel.state.usernameError,
                        isErrorShowed: viewModel.state.isUsernameErrorShowing
                    )
                    .smallLabeled(LocalizedKey.Profile.username)

                TextField("", text: email)
                    .keyboardType(.emailAddress)
                    .formErrorableItem(
                        message: viewModel.state.emailError,
                        isErrorShowed: viewModel.state.isEmailErrorShowing
                    )
                    .smallLabeled(LocalizedKey.Profile.email)

                DatePickerField(date: birthdate)
                    .smallLabeled(LocalizedKey.Profile.birthdate)
            }
        } formAction: {
            viewModel.handle(.continueTapped)
        } calloutAction: {
            viewModel.handle(.logInTapped)
        }
    }

    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
        )
    }

    private var gender: Binding<Gender> {
        Binding(
            get: { viewModel.state.gender },
            set: { viewModel.handle(.genderChanged($0)) }
        )
    }

    private var username: Binding<String> {
        Binding(
            get: { viewModel.state.username },
            set: { viewModel.handle(.usernameChanged($0)) }
        )
    }

    private var email: Binding<String> {
        Binding(
            get: { viewModel.state.email },
            set: { viewModel.handle(.emailChanged($0)) }
        )
    }

    private var birthdate: Binding<Date> {
        Binding(
            get: { viewModel.state.birthdate },
            set: { viewModel.handle(.birthdateChanged($0)) }
        )
    }
}
