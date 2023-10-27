//
//  BaseButtonStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {

    let isProminent: Bool
    @Environment(\.isEnabled) var isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .foregroundStyle(isProminent ? Color(.label) : .appAccent)
            .frame(maxWidth: .infinity)
            .frame(height: Constants.height)
            .background(isProminent ? .appAccent : .appDarkGray)
            .clipShape(.rect(cornerRadius: Constants.borderRadius))
            .opacity(configuration.isPressed ? Constants.opacityPressed : opacity)
            .scaleEffect(configuration.isPressed ? Constants.scaleEffectPressed : Constants.scaleEffect)
    }

    private enum Constants {
        static let height: CGFloat = 42
        static let borderRadius: CGFloat = 10

        static let scaleEffect: CGFloat = 1
        static let scaleEffectPressed: CGFloat = 0.98

        static let opacityEnabled: CGFloat = 1
        static let opacityPressed: CGFloat = 0.7
        static let opacityDisabled: CGFloat = 0.4
    }

    private var opacity: CGFloat {
        isEnabled ? Constants.opacityEnabled : Constants.opacityDisabled
    }
}

extension View {
    func baseButtonStyle(isProminent: Bool = true) -> some View {
        buttonStyle(BaseButtonStyle(isProminent: isProminent))
    }
}
