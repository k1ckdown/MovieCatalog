//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {

    let movie = MockData.movie

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                MovieAsyncImage(imageUrl: movie.poster ?? "")
                    .frame(height: 540)

                VStack(spacing: 18) {
                    HStack {
                        RatingTagView(style: .titleOnly(.medium), value: 9.0)

                        Spacer()

                        Text("Список Шиндлера")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)

                        Spacer()

                        Image(systemName: "heart")
                            .imageScale(.large)
                            .fontWeight(.medium)
                            .padding(9)
                            .background(
                                Circle().fill(.pebble)
                            )
                    }
                    .padding()

                    Text("Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера v Список Шиндлера Список Шиндлера Список Шиндлера Список Шиндлера")
                        .font(.body)
                        .padding(.horizontal, 5)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    MovieDetailsView()
}
