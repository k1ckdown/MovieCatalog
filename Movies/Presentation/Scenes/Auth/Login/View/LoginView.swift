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
            screenTitle: LocalizedKeysConstants.Auth.Label.entrance,
            formButtonTitle: LocalizedKeysConstants.Auth.Action.logIn,
            calloutText: LocalizedKeysConstants.Auth.Callout.noAccountYet,
            calloutButtonTitle: LocalizedKeysConstants.Auth.Callout.registerAccount
        ) {
            Group {
                TextField("", text: username)
                    .formBorderedTextFieldStyle(
                        style: viewModel.state.isLoginErrorShowing ? .error : .default
                    )
                    .smallLabeled(LocalizedKeysConstants.Profile.username)

                SecureInputView(text: password, isErrorShowed: viewModel.state.isLoginErrorShowing)
                    .smallLabeled(LocalizedKeysConstants.Profile.password)

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
