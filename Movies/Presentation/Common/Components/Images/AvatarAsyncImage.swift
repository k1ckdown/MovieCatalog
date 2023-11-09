//
//  AvatarAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct AvatarAsyncImage: View {

    let size: CGFloat
    let url: URL?

    init(size: CGFloat, urlString: String?) {
        self.size = size
        self.url = URL(string: urlString ?? "")
    }

    var body: some View {
        CacheAsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Image(.avatarPlaceholder)
                .resizable()
        }
        .frame(width: size, height: size)
        .clipShape(.circle)
    }
}
