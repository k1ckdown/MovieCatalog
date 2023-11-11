//
//  ReviewView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct ReviewView: View {

    let viewModel: ReviewViewModel
    let optionsTappedHandler: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            HStack {
                AvatarAsyncImage(
                    size: Constants.avatarImageSize,
                    urlString: viewModel.authorAvatarLink
                )

                VStack(alignment: .leading, spacing: Constants.nicknameSpacing) {
                    Text(viewModel.authorNickname)
                    .font(.subheadline)

                    if viewModel.isUserReview {
                        Text(LocalizedKeysConstants.Content.myReview)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                HStack {
                    RatingTagView(
                        style: .titleAndIcon,
                        value: viewModel.rating
                    )

                    if viewModel.isUserReview {
                        Button {
                            optionsTappedHandler()
                        } label: {
                            Image(systemName: Constants.OptionsImage.name)
                                .fontWeight(.semibold)
                        }
                        .padding(Constants.OptionsImage.insets)
                        .background(Circle().fill(.pebble))
                    }
                }
            }

            VStack(alignment: .leading, spacing: Constants.optionsSpacing) {
                Text(viewModel.reviewText)
                Text(viewModel.createDateTime)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private enum Constants {
        static let optionsSpacing: CGFloat = 5
        static let contentSpacing: CGFloat = 10
        static let nicknameSpacing: CGFloat = 3
        static let avatarImageSize: CGFloat = 37

        enum OptionsImage {
            static let name = "ellipsis"
            static let insets: CGFloat = 11
        }
    }
}
