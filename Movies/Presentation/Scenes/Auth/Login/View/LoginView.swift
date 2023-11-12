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
            screenTitle: LocalizedKey.Auth.Label.entrance,
            formButtonTitle: LocalizedKey.Auth.Action.logIn,
            calloutText: LocalizedKey.Auth.Callout.noAccountYet,
            calloutButtonTitle: LocalizedKey.Auth.Callout.registerAccount
        ) {
            Group {
                TextField("", text: username)
                    .formBorderedTextFieldStyle(
                        style: viewModel.state.isLoginErrorShowing ? .error : .default
                    )
                    .smallLabeled(LocalizedKey.Profile.username)

                SecureInputView(text: password, isErrorShowed: viewModel.state.isLoginErrorShowing)
                    .smallLabeled(LocalizedKey.Profile.password)

                if viewModel.state.isLoading {
                    BaseProgressView()
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.bottom, Constants.formBottomInset)
            .errorFooter(
                message: viewModel.state.loginError,
                isShowed: viewModel.state.isLoginErrorShowing
            )
        } formAction: {
            viewModel.handle(.logInTapped)
        } calloutAction: {
            viewModel.handle(.registerTapped)
        }
    }

    private enum Constants {
        static let formBottomInset: CGFloat = 5
    }

    private var username: Binding<String> {
        Binding(
            get: { viewModel.state.username },
            set: { viewModel.handle(.usernameChanged($0)) }
        )
    }

    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }
}
