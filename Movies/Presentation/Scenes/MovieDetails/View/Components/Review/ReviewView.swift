//
//  ReviewView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct ReviewView: View {

    let viewModel: ReviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            HStack {
                AvatarAsyncImage(
                    size: Constants.avatarImageSize,
                    urlString: viewModel.authorAvatarLink
                )

                VStack(alignment: .leading, spacing: Constants.nicknameSpacing) {
                    Text(viewModel.authorNickname ??
                         LocalizedKeysConstants.Content.notAvailable)
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
                        value: Double(viewModel.rating)
                    )

                    if viewModel.isUserReview {
                        Button {

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
                Text(viewModel.reviewText ?? LocalizedKeysConstants.Content.notAvailable)
                Text(viewModel.createDateTime.formatToDateMonthYear())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
    }

    private enum Constants {
        static let optionsSpacing: CGFloat = 5
        static let contentSpacing: CGFloat = 10
        static let nicknameSpacing: CGFloat = 3
        static let avatarImageSize: CGFloat = 35

        enum OptionsImage {
            static let name = "ellipsis"
            static let insets: CGFloat = 11
        }
    }
}

#Preview {
    let mock = ReviewDetails.mock
    let viewModel = ReviewViewModel(
        rating: mock.rating,
        isUserReview: true,
        reviewText: mock.reviewText,
        createDateTime: mock.createDateTime,
        authorNickname: mock.author?.nickName,
        authorAvatarLink: mock.author?.avatar
    )

    return ReviewView(viewModel: viewModel)
        .appBackground()
        .environment(\.locale, .init(identifier: "ru"))
}
