//
//  LoginView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            Form {
                Group {
                    AuthScreenTitle(text: "Entrance")

                    Section {
                        TextField("", text: login)
                            .textFieldStyle(BaseTextFieldStyle())
                    } header: {
                        AuthFormHeader(title: "Login")
                    }

                    Section {
                        SecureInputView(text: password)
                    } header: {
                        AuthFormHeader(title: "Password")
                    }

                    Section {
                        Button("Log In") {

                        }
                        .buttonStyle(BaseButtonStyle())
                        .disabled(viewModel.state.isDataEmpty)
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            }
            .baseFormStyle()
            .scrollDisabled(true)

            Spacer()

            CalloutButton(text: "Don't have an account yet?", buttonTitle: "Register") {

            }
        }
        .appBackground()
        .appNavigationTitle()
    }

    private var login: Binding<String> {
        Binding(
            get: { viewModel.state.login },
            set: { viewModel.handle(.loginChanged($0)) }
        )
    }

    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }
}

#Preview {
    NavigationStack {
        LoginView(viewModel: LoginViewModel())
    }
    .environment(\.locale, .init(identifier: "ru"))
}
