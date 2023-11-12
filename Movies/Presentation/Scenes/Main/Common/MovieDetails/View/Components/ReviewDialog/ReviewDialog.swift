//
//  ReviewDialog.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import SwiftUI

struct ReviewDialog: View {

    @State private var text = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedKey.Review.leave)
                .font(.title2.bold())

            Spacer()

            VStack(alignment: .leading, spacing: Constants.TextEditor.spacing) {
                HStack(spacing: Constants.StarRating.spacing) {
                    ForEach(0...9, id: \.self) { _ in
                        Image(systemName: Constants.StarRating.imageName)
                    }
                    .imageScale(.large)
                    .foregroundStyle(.yellow)
                }

                TextEditor(text: $text)
                    .tint(.appAccent)
                    .frame(height: Constants.TextEditor.height)
                    .clipShape(.rect(cornerRadius: Constants.TextEditor.cornerRadius))
                    .padding(.horizontal, Constants.TextEditor.horizontalInsets)
                    .scrollContentBackground(.hidden)
                    .overlay {
                        RoundedRectangle(cornerRadius: Constants.TextEditor.cornerRadius)
                            .stroke(Color.appGray)
                    }

                HStack {
                    Image(systemName: Constants.Content.checkmarkName)
                        .foregroundStyle(.white, .appAccent)
                        .imageScale(.large)
                        .bold()

                    Text(LocalizedKey.Review.anonymous)
                        .font(.callout.weight(.medium))
                }
            }

            Spacer()

            VStack {
                Button(LocalizedKey.Profile.save) {

                }
                .baseButtonStyle()
                .disabled(text.isEmpty)

                Button(LocalizedKey.Profile.cancel) {

                }
                .baseButtonStyle(isProminent: false)
            }
            .padding(.top)
        }
        .padding()
        .appBackground()
        .frame(height: Constants.Content.height)
        .clipShape(.rect(cornerRadius: Constants.Content.cornerRadius))
    }

    private enum Constants {
        enum StarRating {
            static let spacing: CGFloat = 5
            static let imageName = "star.fill"
        }

        enum TextEditor {
            static let spacing: CGFloat = 12
            static let height: CGFloat = 105
            static let cornerRadius: CGFloat = 5
            static let horizontalInsets: CGFloat = 6
        }

        enum Content {
            static let height: CGFloat = 375
            static let cornerRadius: CGFloat = 10
            static let checkmarkName = "checkmark.square.fill"
        }
    }
}

#Preview {
    ReviewDialog()
        .padding(.horizontal, 35)
        .environment(\.locale, .init(identifier: "ru"))
}
