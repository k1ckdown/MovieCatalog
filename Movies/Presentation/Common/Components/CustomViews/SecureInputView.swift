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
            .overlay(alignment: .trailing) {
                Button {
                    isSecured.toggle()
                } label: {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                }
                .imageScale(.medium)
                .tint(.secondary)
                .padding(.trailing, Constants.eyeButtonTrailingInset)
            }
    }
    
    private enum Constants {
        static let eyeButtonTrailingInset: CGFloat = 12
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
