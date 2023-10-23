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
        VStack {
            Form {
                Group {
                    AuthScreenTitle(text: LocalizedKeysConstants.registration)

                    Section {
                        SecureInputView(text: $password)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.password)
                    }

                    Section {
                        SecureInputView(text: $confirmPassword)
                    } header: {
                        AuthFormHeader(title: LocalizedKeysConstants.confirmPassword)
                    }

                    Section {
                        Button(LocalizedKeysConstants.registerAccount) {

                        }
                        .buttonStyle(BaseButtonStyle())
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

            Button(LocalizedKeysConstants.logInToAccount) {

            }
            .buttonStyle(CalloutButtonStyle(calloutText: LocalizedKeysConstants.alreadyHaveAccount))
        }
        .appBackground()
        .appNavigationTitle()
    }
}

#Preview {
    NavigationStack {
        RegistrationSecondStageView()
    }
    .environment(\.locale, .init(identifier: "ru"))
}
