//
//  CalloutButton.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct CalloutButton: View {

    let text: LocalizedStringKey
    let buttonTitle: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        HStack(spacing: Constants.spacing) {
            Text(text)
                .foregroundStyle(.appLightGray)

            Button(buttonTitle) {
                action()
            }
            .tint(.appAccent)
            .fontWeight(.medium)
        }
        .font(.callout)
        .padding(.bottom)
    }

    private enum Constants {
        static let spacing: CGFloat = 6
    }
}
