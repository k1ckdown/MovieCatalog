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
        AuthView(
            style: .login,
            isFormButtonDisabled: viewModel.state.isLogInDisabled,
            screenTitle: LocalizedKeysConstants.entrance,
            formButtonTitle: LocalizedKeysConstants.logIn,
            calloutText: LocalizedKeysConstants.noAccountYet,
            calloutButtonTitle: LocalizedKeysConstants.register
        ) {
            Group {
                TextField("", text: login)
                    .formBorderedTextFieldStyle()
                    .labeled(LocalizedKeysConstants.username)

                SecureInputView(text: password)
                    .labeled(LocalizedKeysConstants.password)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        } formAction: {
            viewModel.handle(.onTapLogIn)
        } calloutAction: {
            viewModel.handle(.onTapRegister)
        }
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
    LoginView(viewModel: .init(router: .init(path: .constant(.init()))))
}
