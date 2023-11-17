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
                    urlString: viewModel.shouldShowAnonymous ? nil : viewModel.authorAvatarLink
                )

                VStack(alignment: .leading, spacing: Constants.nicknameSpacing) {
                    Text(viewModel.shouldShowAnonymous
                         ? LocalizedKey.Review.anonymousUser
                         : LocalizedStringKey(viewModel.authorNickname))
                    .fontWeight(.medium)

                    if viewModel.isUserReview {
                        Text(LocalizedKey.Movie.myReview)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                HStack(spacing: Constants.OptionsButton.spacing) {
                    RatingTagView(
                        style: .titleAndIcon,
                        value: Double(viewModel.rating)
                    )

                    if viewModel.isUserReview {
                        Button {
                            optionsTappedHandler()
                        } label: {
                            Image(systemName: Constants.OptionsButton.imageName)
                                .tint(.accent)
                                .fontWeight(.semibold)
                        }
                        .padding(Constants.OptionsButton.insets)
                        .frame(width: Constants.OptionsButton.size, height: Constants.OptionsButton.size)
                        .background(Circle().fill(.pebble))
                    }
                }
            }

            VStack(alignment: .leading, spacing: Constants.dateSpacing) {
                Text(viewModel.reviewText)

                Text(viewModel.createDateTime)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private enum Constants {
        static let dateSpacing: CGFloat = 5
        static let contentSpacing: CGFloat = 10
        static let nicknameSpacing: CGFloat = 3
        static let avatarImageSize: CGFloat = 43

        enum OptionsButton {
            static let size: CGFloat = 32
            static let insets: CGFloat = 11
            static let spacing: CGFloat = 13
            static let imageName = "ellipsis"
        }
    }
}
