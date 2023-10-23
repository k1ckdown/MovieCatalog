//
//  RegistrationSecondStageView.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct RegistrationSecondStageView: View {

    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        AuthView(
            style: .registrationSecondStage,
            screenTitle: LocalizedKeysConstants.registration,
            formButtonTitle: LocalizedKeysConstants.registerAccount,
            calloutText: LocalizedKeysConstants.alreadyHaveAccount,
            calloutButtonTitle: LocalizedKeysConstants.logInToAccount) {
                Group {
                    SecureInputView(text: $password)
                        .labeled(LocalizedKeysConstants.password)

                    SecureInputView(text: $confirmPassword)
                        .labeled(LocalizedKeysConstants.confirmPassword)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            } formAction: {

            } calloutAction: {

            }
    }
}

#Preview {
    NavigationStack {
        RegistrationSecondStageView()
    }
    .environment(\.locale, .init(identifier: "ru"))
}
