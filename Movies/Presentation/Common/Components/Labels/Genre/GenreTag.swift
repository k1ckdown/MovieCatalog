//
//  GenreTag.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct GenreTag: View {

    enum Style {
        case note
        case body

        var horizontalInsets: CGFloat {
            switch self {
            case .note: 8
            case .body: 11
            }
        }

        var verticalInsets: CGFloat {
            switch self {
            case .note: 3
            case .body: 5
            }
        }

        var backgroundColor: Color {
            switch self {
            case .note: .pebble
            case .body: .appAccent
            }
        }

        var font: Font {
            switch self {
            case .note:
                return .subheadline
            case .body:
                return .callout.weight(.medium)
            }
        }
    }

    let viewModel: GenreViewModel

    var body: some View {
        Text(viewModel.name)
            .font(viewModel.style.font)
            .padding(.vertical, viewModel.style.verticalInsets)
            .padding(.horizontal, viewModel.style.horizontalInsets)
            .background(viewModel.style.backgroundColor)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 5
    }
}
