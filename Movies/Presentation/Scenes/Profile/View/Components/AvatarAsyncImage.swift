//
//  AvatarAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct AvatarAsyncImage: View {

    let link: String

    var body: some View {
        AsyncImage(url: URL(string: link)) { image in
            image
                .resizable()
        } placeholder: {
            Image(.profilePlaceholder)
                .resizable()
                .scaledToFill()
        }
        .frame(width: Constants.size, height: Constants.size)
        .clipShape(.circle)
        .overlay {
            Circle()
                .stroke(.appDarkGray, lineWidth: Constants.borderWidth)
        }
    }

    private enum Constants {
        static let size: CGFloat = 80
        static let borderWidth: CGFloat = 2
    }
}
