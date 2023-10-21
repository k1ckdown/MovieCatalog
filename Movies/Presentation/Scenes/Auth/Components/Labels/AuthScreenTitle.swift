//
//  AuthScreenTitle.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct AuthScreenTitle: View {
    
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .padding(.top)
            .frame(maxWidth: .infinity)
    }
}
