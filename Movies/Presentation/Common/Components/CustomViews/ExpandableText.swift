//
//  ExpandableText.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import SwiftUI

struct ExpandableText: View {

    let text: String
    let lineLimit: Int
    let fontSize: CGFloat

    @State private var isExpanded = false
    @State private var isTruncated = false

    init(
        text: String,
        fontSize: CGFloat = Constants.fontSize,
        lineLimit: Int = Constants.Text.lineLimit
    ) {
        self.text = text
        self.fontSize = fontSize
        self.lineLimit = lineLimit
    }

    var body: some View{
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(text)
                .font(.system(size: fontSize))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(isExpanded ? nil : lineLimit)
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
                Text(LocalizedKey.Content.readMore)
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
        let total = text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: fontSize)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            isTruncated = true
        }
    }

    private enum Constants {
        static let fontSize: CGFloat = 17
        static let degrees: Double = -180
        static let animationDuration = 0.4
        static let startDegrees: Double = 0
        static let contentSpacing: CGFloat = 5

        enum Text {
            static let lineLimit = 2
            static let gradientEndOpacity: CGFloat = 0
        }

        enum Label {
            static let spacing: CGFloat = 12
            static let topInset: CGFloat = 30
            static let imageName = "chevron.down"
        }
    }
}
