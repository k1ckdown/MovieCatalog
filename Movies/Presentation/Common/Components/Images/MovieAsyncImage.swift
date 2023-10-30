//
//  MovieAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MovieAsyncImage: View {

    let imageUrl: String?

    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
            image
                .resizable()
        } placeholder: {
            Image(.moviePlaceholder)
                .resizable()
                .scaledToFill()
        }
    }
}
