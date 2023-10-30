//
//  FavoriteButton.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct FavoriteButton: View {

    let isSet: Bool
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: isSet ? Constants.heartFill : Constants.heart)
                .imageScale(.large)
                .fontWeight(.medium)
                .foregroundStyle(isSet ? .red : .white)
        }
        .padding(Constants.insets)
        .background(
            Circle().fill(.pebble)
        )
    }
    
    private enum Constants {
        static let heart = "heart"
        static let heartFill = "heart.fill"
        static let insets: CGFloat = 9
    }
}
