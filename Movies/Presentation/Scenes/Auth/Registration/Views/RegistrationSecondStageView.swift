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
                    AuthScreenTitle(text: "Registration")

                    Section {
                        SecureInputView(text: $password)
                    } header: {
                        AuthFormHeader(title: "Password")
                    }

                    Section {
                        SecureInputView(text: $confirmPassword)
                    } header: {
                        AuthFormHeader(title: "Confirm password")
                    }

                    Section {
                        Button("Register account") {

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

            CalloutButton(text: "Already have an account?",
                          buttonTitle: "Log in to account") {
            }
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
