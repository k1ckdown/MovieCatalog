//
//  BaseButton.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct BaseButton: View {
    
    let title: LocalizedStringKey
    let isProminent: Bool
    let action: () -> Void
    
    init(title: LocalizedStringKey, isProminent: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isProminent = isProminent
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .fontWeight(.semibold)
                .foregroundStyle(isProminent ? Color(.label) : .appAccent)
                .frame(width: Constants.width, height: Constants.height)
                .background(isProminent ? .appAccent : .appDarkGray)
                .clipShape(.rect(cornerRadius: Constants.borderRadius))
        }
    }
    
    private enum Constants {
        static let height: CGFloat = 42
        static let width: CGFloat = 360
        static let borderRadius: CGFloat = 10
    }
}
