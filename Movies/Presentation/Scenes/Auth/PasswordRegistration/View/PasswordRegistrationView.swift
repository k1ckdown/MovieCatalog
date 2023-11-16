//
//  PasswordRegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct PasswordRegistrationView: View {

    @StateObject private var viewModel: PasswordRegistrationViewModel

    init(viewModel: PasswordRegistrationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AuthView(
            style: .passwords,
            isFormButtonDisabled: viewModel.state.isRegisterDisabled,
            screenTitle: LocalizedKey.Auth.Label.registration,
            formButtonTitle: LocalizedKey.Auth.Action.register,
            calloutText: LocalizedKey.Auth.Callout.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKey.Auth.Callout.logInToAccount) {
                Group {
                    SecureInputView(
                        text: password,
                        errorMessage: viewModel.state.passwordError,
                        isErrorShowed: viewModel.state.isPasswordErrorShowing
                    )
                    .smallLabeled(LocalizedKey.Profile.password)

                    SecureInputView(
                        text: confirmPassword,
                        errorMessage: viewModel.state.confirmPasswordError,
                        isErrorShowed: viewModel.state.isConfirmPasswordErrorShowing
                    )
                    .smallLabeled(LocalizedKey.Profile.confirmPassword)

                    if viewModel.state.isLoading {
                        BaseProgressView()
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.bottom)
                .errorFooter(
                    message: viewModel.state.registerError,
                    isShowed: viewModel.state.isRegisterErrorShowing
                )
            } formAction: {
                viewModel.handle(.registerTapped)
            } calloutAction: {
                viewModel.handle(.logInTapped)
            }
    }

    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }

    private var confirmPassword: Binding<String> {
        Binding(
            get: { viewModel.state.confirmPassword },
            set: { viewModel.handle(.confirmPasswordChanged($0)) }
        )
    }
}
