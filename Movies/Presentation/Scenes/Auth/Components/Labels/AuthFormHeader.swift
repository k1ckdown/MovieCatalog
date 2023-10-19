//
//  AuthFormHeader.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct AuthFormHeader: View {

    let title: LocalizedStringKey

    var body: some View {
        Text(title)
            .font(.system(size: Constants.fontSize, weight: .medium))
            .foregroundStyle(Color(.label))
            .padding(.bottom, Constants.bottomInset)
            .headerProminence(.increased)
    }

    private enum Constants {
        static let fontSize: CGFloat = 17
        static let bottomInset: CGFloat = 10
    }
}
