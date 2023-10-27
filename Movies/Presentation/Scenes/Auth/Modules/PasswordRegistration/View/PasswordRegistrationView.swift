//
//  PasswordRegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct PasswordRegistrationView: View {

    @ObservedObject private(set) var viewModel: PasswordRegistrationViewModel

    var body: some View {
        AuthView(
            style: .passwords,
            isFormButtonDisabled: viewModel.state.isRegisterDisabled,
            screenTitle: LocalizedKeysConstants.Auth.Label.registration,
            formButtonTitle: LocalizedKeysConstants.Auth.Action.register,
            calloutText: LocalizedKeysConstants.Auth.Callout.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKeysConstants.Auth.Callout.logInToAccount) {
                Group {
                    SecureInputView(
                        text: password,
                        errorMessage: viewModel.state.passwordError,
                        isErrorShowed: viewModel.state.isPasswordErrorShowing
                    )
                    .labeled(LocalizedKeysConstants.Profile.password)

                    SecureInputView(
                        text: confirmPassword,
                        errorMessage: viewModel.state.confirmPasswordError,
                        isErrorShowed: viewModel.state.isConfirmPasswordErrorShowing
                    )
                    .labeled(LocalizedKeysConstants.Profile.confirmPassword)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            } formAction: {
                viewModel.handle(.onTapRegister)
            } calloutAction: {
                viewModel.handle(.onTapLogIn)
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

//#Preview {
//    PasswordRegistrationView(viewModel: .init(router: .init(path: .constant(.init())), validatePasswordUseCase: .init()))
//}
