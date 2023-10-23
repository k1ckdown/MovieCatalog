//
//  RegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct RegistrationFirstStageView: View {

    @ObservedObject private(set) var viewModel: RegistrationViewModel

    var body: some View {
        AuthView(
            style: .registrationFirstStage,
            screenTitle: LocalizedKeysConstants.registration,
            formButtonTitle: LocalizedKeysConstants.continue,
            calloutText: LocalizedKeysConstants.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKeysConstants.logInToAccount
        ) {
            Group {
                TextField("", text: name)
                    .labeled(LocalizedKeysConstants.name)

                BaseSegmentedPicker(selection: gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(LocalizedStringKey(gender.rawValue)).tag(gender)
                    }
                }
                .frame(height: Constants.genderPickerHeight)
                .labeled(LocalizedKeysConstants.gender)

                TextField("", text: login)
                    .textInputAutocapitalization(.never)
                    .labeled(LocalizedKeysConstants.login)

                TextField("", text: email)
                    .keyboardType(.emailAddress)
                    .labeled(LocalizedKeysConstants.email)

                DatePickerField(date: birthdate)
                    .labeled(LocalizedKeysConstants.birthdate)
            }
            .textFieldStyle(BaseTextFieldStyle())
        } formAction: {

        } calloutAction: {

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

    private var login: Binding<String> {
        Binding(
            get: { viewModel.state.login },
            set: { viewModel.handle(.loginChanged($0)) }
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

#Preview {
    NavigationStack {
        RegistrationFirstStageView(viewModel: RegistrationViewModel())
            .environment(\.locale, .init(identifier: "ru"))
    }
}
