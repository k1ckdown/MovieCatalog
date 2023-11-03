//
//  ExpandableText.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import SwiftUI

struct ExpandableText: View {

    let text: String

    @State private var isExpanded = false
    @State private var isTruncated = false

    var body: some View{
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(isExpanded ? nil : Constants.Text.lineLimit)
                .overlay {
                    if isExpanded == false, isTruncated == true {
                        gradient
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear.onAppear {
                            determineTruncation(proxy)
                        }
                    }
                )

            if isTruncated {
                moreButton
            }
        }
    }

    private var gradient: LinearGradient {
        .linearGradient(
            colors: [
                .background,
                .background.opacity(Constants.Text.gradientEndOpacity)
            ],
            startPoint: .bottom,
            endPoint: .center
        )
    }

    private var moreButton: some View {
        Button {
            withAnimation(.easeOut(duration: Constants.animationDuration)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: Constants.Label.spacing) {
                Text(LocalizedKeysConstants.Content.readMore)
                    .font(.callout)

                Image(systemName: Constants.Label.imageName)
                    .imageScale(.medium)
                    .rotationEffect(.degrees(isExpanded ? Constants.degrees : Constants.startDegrees))
            }
            .fontWeight(.semibold)
            .foregroundStyle(.appAccent)
        }
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.isTruncated = true
        }
    }

    private enum Constants {
        static let degrees: Double = -180
        static let animationDuration = 0.4
        static let startDegrees: Double = 0
        static let contentSpacing: CGFloat = 5

        enum Text {
            static let lineLimit = 4
            static let gradientEndOpacity: CGFloat = 0
        }

        enum Label {
            static let spacing: CGFloat = 12
            static let topInset: CGFloat = 30
            static let imageName = "chevron.down"
        }
    }
}
