//
//  ErrorView.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//

import SwiftUI

struct ErrorView: View {

    let message: String

    var body: some View {
        VStack {
            VStack(spacing: Constants.contentSpacing) {
                Image(.amico)
                    .resizable()
                    .frame(
                        width: Constants.imageSize,
                        height: Constants.imageSize
                    )

                Text(message)
                    .font(.headline.weight(.medium))
                    .multilineTextAlignment(.center)
            }
        }
        .offset(y: Constants.offsetY)
        .backgroundColor()
    }

    private enum Constants {
        static let offsetY: CGFloat = -50
        static let imageSize: CGFloat = 320
        static let contentSpacing: CGFloat = 45
    }
}
