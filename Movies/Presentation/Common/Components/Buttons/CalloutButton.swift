//
//  CalloutButton.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct CalloutButtonStyle: ButtonStyle {

    let calloutText: LocalizedStringKey

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: Constants.spacing) {
            Text(calloutText)
                .foregroundStyle(.appLightGray)

            configuration.label
                .foregroundStyle(.appAccent)
                .fontWeight(.medium)
        }
        .font(.callout)
        .padding(.bottom)
    }

    private enum Constants {
        static let spacing: CGFloat = 6
    }
}
