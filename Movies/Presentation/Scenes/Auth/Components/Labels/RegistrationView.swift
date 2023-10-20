//
//  RegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct RegistrationView<ViewModel: RegistrationViewModelProtocol>: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            Form {
                Group {
                    ScreenTitle(text: "Registration")

                    Section {
                        TextField("", text: name)
                    } header: {
                        AuthFormHeader(title: "Name")
                    }

                    Section {
                        BaseSegmentedPicker(selection: gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(LocalizedStringKey(gender.rawValue)).tag(gender)
                            }
                        }
                    } header: {
                        AuthFormHeader(title: "Gender")
                    }

                    Section {
                        TextField("", text: login)
                            .textInputAutocapitalization(.never)
                    } header: {
                        AuthFormHeader(title: "Login")
                    }

                    Section {
                        TextField("", text: email)
                            .keyboardType(.emailAddress)
                    } header: {
                        AuthFormHeader(title: "Email")
                    }

                    Section {
                        DatePickerField(date: birthdate)
                    } header: {
                        AuthFormHeader(title: "Birthdate")
                    }

                    Section {
                        Button("Сontinue") {

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

            CalloutButton(text: "Already have an account?",
                          buttonTitle: "Log in to account") {
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
        RegistrationView(viewModel: RegistrationViewModel())
            .environment(\.locale, .init(identifier: "ru"))
    }
}
