//
//  BaseTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct BaseTextFieldStyle: TextFieldStyle {

    enum Style {
        case `default`
        case error

        var tintColor: Color {
            switch self {
            case .default: .appAccent
            case .error: .appLightGray
            }
        }

        var borderColor: Color {
            switch self {
            case .default: .appGray
            case .error: .red
            }
        }

        var backgroundColor: Color {
            switch self {
            case .default:
                return .clear
            case .error:
                return .red.opacity(Constants.errorOpacity)
            }
        }
    }

    let style: Style
    let trailingInset: CGFloat

    init(_ style: Style = .default, trailingInset: CGFloat = Constants.horizontalInset) {
        self.style = style
        self.trailingInset = trailingInset
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .tintColor(style.tintColor)
            .frame(height: Constants.height)
            .padding(.leading, Constants.horizontalInset)
            .padding(.trailing, trailingInset)
            .padding(.vertical, Constants.verticalInset)
            .background(background)
    }

    @ViewBuilder
    private var background: some View {
        let rectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)

        rectangle
            .stroke(style.borderColor)
            .background(rectangle.fill(style.backgroundColor))
    }

    private enum Constants {
        static let verticalInset: CGFloat = 2
        static let horizontalInset: CGFloat = 12

        static let height: CGFloat = 37
        static let cornerRadius: CGFloat = 10
        static let errorOpacity: CGFloat = 0.1
    }
}
