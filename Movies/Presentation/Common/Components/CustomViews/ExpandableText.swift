//
//  ExpandableText.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import SwiftUI

struct ExpandableText: View {

    let text: String
    @State private var isExpanded: Bool = false

    var body: some View{
        VStack {
            Text(text)
                .lineLimit(isExpanded ? nil : Constants.Text.lineLimit)
                .overlay {
                    if isExpanded == false {
                        LinearGradient(
                            colors: [
                                .background,
                                .background.opacity(Constants.Text.gradientEndOpacity)
                            ],
                            startPoint: .bottom,
                            endPoint: .center
                        )
                    }
                }
                .overlay(
                    GeometryReader { proxy in
                        Button {
                            withAnimation(.easeOut(duration: Constants.animationDuration)) {
                                isExpanded.toggle()
                            }
                        } label: {
                            moreLabel
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomLeading)
                        .padding(.top, Constants.Label.topInset)
                    }
                )
        }
        .padding(.bottom, Constants.Label.topInset)
    }

    private var moreLabel: some View {
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

    private enum Constants {
        static let degrees: Double = -180
        static let animationDuration = 0.4
        static let startDegrees: Double = 0

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
