//
//  MovieAsyncImage.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct MovieAsyncImage: View {

    let urlString: String?

    var body: some View {
        AsyncImage(
            url: URL(string: urlString ?? ""),
            transaction: .init(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.appAccent)

            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: Constants.scale, anchor: .center))

            case .failure:
                Image(.moviePlaceholder)
                    .resizable()
                    .scaledToFill()

            @unknown default:
                EmptyView()
            }
        }
    }

    private enum Constants {
        static let scale = 0.1
    }
}
