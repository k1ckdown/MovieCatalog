//
//  ScreenTitle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct ScreenTitle: View {

    let text: LocalizedStringKey

    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .listRowInsets(.init(top: 0, leading: 0, bottom: Constants.bottomInset, trailing: 0))
    }

    private enum Constants {
        static let bottomInset: CGFloat = -20
    }
}
