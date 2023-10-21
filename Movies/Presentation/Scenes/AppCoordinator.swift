//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppCoordinator: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            WelcomeCoordinator(state: .init(path: $path))
        }
    }
}

#Preview {
    AppCoordinator()
        .environment(\.locale, .init(identifier: "ru"))
}
