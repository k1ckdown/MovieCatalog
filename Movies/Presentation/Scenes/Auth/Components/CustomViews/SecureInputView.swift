//
//  SecureInputView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct SecureInputView: View {

    @Binding var text: String

    var errorMessage: String?
    var isErrorShowed: Bool = false

    @State private var isSecured = false

    var body: some View {
        HStack(spacing: Constants.contentSpacing) {
            textField
                .labelsHidden()

            Image(systemName: isSecured ? Constants.Image.eyeSlash : Constants.Image.eye)
                .imageScale(.medium)
                .foregroundStyle(.secondary)
                .padding(.trailing)
                .onTapGesture {
                    isSecured.toggle()
                }
        }
        .formErrorableItem(
            message: errorMessage,
            isErrorShowed: isErrorShowed
        )
    }

    private enum Constants {
        static let contentSpacing: CGFloat = 0

        enum Image {
            static let eye = "eye"
            static let eyeSlash = "eye.slash"
            static let trailingInset: CGFloat = 12
        }
    }

    @ViewBuilder
    private var textField: some View {
        if isSecured {
            SecureField("", text: $text)
        } else {
            TextField("", text: $text)
        }
    }
}
