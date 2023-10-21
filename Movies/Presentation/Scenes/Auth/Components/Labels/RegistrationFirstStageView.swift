//
//  RegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct RegistrationFirstStageView<ViewModel: RegistrationViewModelProtocol>: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            Form {
                Group {
                    AuthScreenTitle(text: LocalizedKeysConstants.registration)

                    Section {
                        TextField("", text: name)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.name)
                    }

                    Section {
                        BaseSegmentedPicker(selection: gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(LocalizedStringKey(gender.rawValue)).tag(gender)
                            }
                        }
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.gender)
                    }

                    Section {
                        TextField("", text: login)
                            .textInputAutocapitalization(.never)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.login)
                    }

                    Section {
                        TextField("", text: email)
                            .keyboardType(.emailAddress)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.email)
                    }

                    Section {
                        DatePickerField(date: birthdate)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.birthdate)
                    }

                    Section {
                        Button(LocalizedKeysConstants.continue) {

                        }
                        .buttonStyle(BaseButtonStyle())
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .textFieldStyle(BaseTextFieldStyle())
            }
            .baseFormStyle()

            Spacer()

            CalloutButton(text: LocalizedKeysConstants.alreadyHaveAccount,
                          buttonTitle: LocalizedKeysConstants.logInToAccount) {
            }
        }
        .appBackground()
        .appNavigationTitle()
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
