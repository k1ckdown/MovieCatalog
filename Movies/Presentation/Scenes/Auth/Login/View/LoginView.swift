//
//  LoginView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject private(set) var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Form {
                Group {
                    AuthScreenTitle(text: LocalizedKeysConstants.entrance)

                    Section {
                        TextField("", text: login)
                            .textFieldStyle(BaseTextFieldStyle())
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.login)
                    }

                    Section {
                        SecureInputView(text: password)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.password)
                    }

                    Section {
                        Button(LocalizedKeysConstants.logIn) {

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

            Button(LocalizedKeysConstants.register) {
                viewModel.handle(.onTapRegister)
            }
            .buttonStyle(CalloutButtonStyle(calloutText: LocalizedKeysConstants.noAccountYet))
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

//#Preview {
//    LoginView(viewModel: LoginViewModel(navigationState: .init(path: .constant(.init()))))
//}
