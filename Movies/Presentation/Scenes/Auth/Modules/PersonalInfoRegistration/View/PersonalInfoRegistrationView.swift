//
//  PersonalInfoRegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct PersonalInfoRegistrationView: View {

    @ObservedObject private(set) var viewModel: PersonalInfoRegistrationViewModel

    var body: some View {
        AuthView(
            style: .personalInfo,
            screenTitle: LocalizedKeysConstants.registration,
            formButtonTitle: LocalizedKeysConstants.continue,
            calloutText: LocalizedKeysConstants.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKeysConstants.logInToAccount
        ) {
            Group {
                TextField("", text: name)
                    .labeled(LocalizedKeysConstants.name)
                    .textFieldStyle(BaseTextFieldStyle())

                BaseSegmentedPicker(selection: gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(LocalizedStringKey(gender.rawValue)).tag(gender)
                    }
                }
                .frame(height: Constants.genderPickerHeight)
                .labeled(LocalizedKeysConstants.gender)

                ErrorableTextField(text: username, message: usernameErrorMessage)
                    .textInputAutocapitalization(.never)
                    .labeled(LocalizedKeysConstants.username)

                ErrorableTextField(text: email, message: emailErrorMessage)
                    .keyboardType(.emailAddress)
                    .labeled(LocalizedKeysConstants.email)

                DatePickerField(date: birthdate)
                    .labeled(LocalizedKeysConstants.birthdate)
            }
        } formAction: {
            viewModel.handle(.onTapContinue)
        } calloutAction: {
            viewModel.handle(.onTapLogIn)
        }
    }

    private enum Constants {
        static let genderPickerHeight: CGFloat = 43
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

    private var emailErrorMessage: Binding<String?> {
        Binding(
            get: { viewModel.state.emailError },
            set: { _ in }
        )
    }

    private var usernameErrorMessage: Binding<String?> {
        Binding(
            get: { viewModel.state.usernameError },
            set: { _ in }
        )
    }
}

#Preview {
    PersonalInfoRegistrationView(
        viewModel: .init(
            router: .init(path: .constant(.init())),
            validateEmailUseCase: .init()
        )
    )
}
