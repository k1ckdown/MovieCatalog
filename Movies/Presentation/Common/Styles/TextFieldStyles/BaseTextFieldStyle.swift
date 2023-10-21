//
//  BaseTextFieldStyle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct BaseTextFieldStyle: TextFieldStyle {

    let trailingInset: CGFloat

    init(trailingInset: CGFloat = Constants.horizontalInset) {
        self.trailingInset = trailingInset
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .tint(.appAccent)
            .frame(height: Constants.height)
            .padding(.leading, Constants.horizontalInset)
            .padding(.trailing, trailingInset)
            .padding(.vertical, Constants.verticalInset)
            .grayBordered()
    }

    private enum Constants {
        static let height: CGFloat = 37
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let verticalInset: CGFloat = 2
        static let horizontalInset: CGFloat = 12
    }
}
