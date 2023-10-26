//
//  SecureInputView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct SecureInputView: View {

    @Binding var text: String
    @State private var isSecured = false

    var body: some View {
        textField
            .labelsHidden()
            .textFieldStyle(
                BaseTextFieldStyle(trailingInset: Constants.TextField.trailingInset)
            )
            .overlay(alignment: .trailing) {
                Image(systemName: isSecured ? Constants.Image.eyeSlash : Constants.Image.eye)
                    .imageScale(.medium)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Constants.Image.trailingInset)
                    .onTapGesture {
                        isSecured.toggle()
                    }
            }
    }

    private enum Constants {
        enum TextField {
            static let trailingInset: CGFloat = 45
        }

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
