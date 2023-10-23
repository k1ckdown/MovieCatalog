//
//  AuthView.swift
//  Movies
//
//  Created by Ivan Semenov on 24.10.2023.
//

import SwiftUI

struct AuthView<Content: View>: View {

    enum Style {
        case login
        case registrationFirstStage
        case registrationSecondStage

        var contentSpacing: CGFloat {
            12
        }

        var formButtonSpacing: CGFloat {
            30
        }

        var formSpacing: CGFloat {
            switch self {
            case .registrationFirstStage: 12
            case .login, .registrationSecondStage: 18
            }
        }
    }

    let style: Style
    let screenTitle: LocalizedStringKey
    let formButtonTitle: LocalizedStringKey

    let calloutText: LocalizedStringKey
    let calloutButtonTitle: LocalizedStringKey

    let formContent: () -> Content
    let formAction: () -> Void
    let calloutAction: () -> Void

    var body: some View {
        VStack(spacing: style.contentSpacing) {
            AuthScreenTitle(text: screenTitle)

            VStack(spacing: style.formButtonSpacing) {
                VStack(spacing: style.formSpacing) {
                    formContent()
                }

                Button(formButtonTitle) {
                    formAction()
                }
                .buttonStyle(BaseButtonStyle())
            }
            .padding(.horizontal)

            Spacer()

            Button(calloutButtonTitle) {
                calloutAction()
            }
            .buttonStyle(CalloutButtonStyle(calloutText: calloutText))
        }
        .padding(.top)
        .appBackground()
        .appNavigationTitle()
    }
}
