//
//  BaseProgressView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct BaseProgressView: View {

    var body: some View {
        ProgressView()
            .tint(.appAccent)
            .frame(maxWidth: .infinity)
    }
}
