//
//  AvatarAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct AvatarAsyncImage: View {

    let size: CGFloat
    let urlString: String?

    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) { image in
            image
                .resizable()
        } placeholder: {
            Image(.avatarPlaceholder)
                .resizable()
                .scaledToFill()
        }
        .frame(width: size, height: size)
        .clipShape(.circle)
    }
}
