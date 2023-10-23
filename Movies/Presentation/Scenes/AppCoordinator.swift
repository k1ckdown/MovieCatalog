//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppCoordinator: View {

    @State private var path = NavigationPath()
    private let coordinatorFactory: CoordinatorFactory

    init(coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
    }

    var body: some View {
        NavigationStack(path: $path) {
            coordinatorFactory.makeWelcomeCoordinator(with: .init(path: $path))
        }
    }
}

#Preview {
    AppCoordinator(coordinatorFactory: .init())
        .environment(\.locale, .init(identifier: "ru"))
}
