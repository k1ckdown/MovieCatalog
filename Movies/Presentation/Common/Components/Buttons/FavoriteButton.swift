//
//  FavoriteButton.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct FavoriteButton: View {

    enum Size {
        case small
        case medium

        var value: CGFloat {
            switch self {
            case .small: Constants.Size.small
            case .medium: Constants.Size.medium
            }
        }
    }

    let size: Size
    let isSet: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            Color.pebble

            Image(systemName: isSet ? Constants.heartFill : Constants.heart)
                .imageScale(.large)
                .foregroundStyle(isSet ? .appAccent : .white)
                .onTapGesture {
                    withAnimation {
                        action()
                    }
                }
        }
        .frame(width: size.value, height: size.value)
        .clipShape(.circle)
    }

    private enum Constants {
        static let heart = "heart"
        static let heartFill = "heart.fill"

        enum Size {
            static let small: CGFloat = 36
            static let medium: CGFloat = 41
        }
    }
}
