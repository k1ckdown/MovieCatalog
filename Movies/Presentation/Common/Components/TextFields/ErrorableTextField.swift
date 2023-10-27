//
//  ErrorableTextField.swift
//  Movies
//
//  Created by Ivan Semenov on 27.10.2023.
//

import SwiftUI

struct ErrorableTextField: View {

    @Binding var text: String
    @Binding var message: String?

    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $text)
                .textFieldStyle(
                    BaseTextFieldStyle(isErrorShowed ? .error : .default)
                )

            if isErrorShowed {
                Text(message ?? "")
                    .font(.callout)
                    .foregroundStyle(.red)
                    .animation(.bouncy, value: message)
            }
        }
    }

    private var isErrorShowed: Bool {
        text.isEmpty == false && message != nil
    }
}
