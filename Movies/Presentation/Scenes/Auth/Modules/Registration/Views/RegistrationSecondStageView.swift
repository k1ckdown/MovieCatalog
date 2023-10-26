//
//  RegistrationSecondStageView.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct RegistrationSecondStageView: View {
    
    @ObservedObject private(set) var viewModel: RegistrationViewModel
    
    var body: some View {
        AuthView(
            style: .registrationSecondStage,
            screenTitle: LocalizedKeysConstants.registration,
            formButtonTitle: LocalizedKeysConstants.registerAccount,
            calloutText: LocalizedKeysConstants.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKeysConstants.logInToAccount) {
                Group {
                    SecureInputView(text: password)
                        .labeled(LocalizedKeysConstants.password)
                    
                    SecureInputView(text: confirmPassword)
                        .labeled(LocalizedKeysConstants.confirmPassword)
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
