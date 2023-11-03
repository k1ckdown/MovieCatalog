//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppCoordinator: View {

    enum Scene {
        case auth
        case main
    }

    @State private var currentScene = Scene.auth
    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    var body: some View {
        switch currentScene {
        case .auth:
            AuthCoordinatorView(makeAuthCoordinator(), factory: screenFactory)
        case .main:
            MainCoordinatorView(factory: screenFactory)
        }
    }

    func makeAuthCoordinator() -> AuthCoordinator {
        let showMainSceneHandler: () -> Void = {
            currentScene = .main
        }
        return AuthCoordinator(showMainSceneHandler: showMainSceneHandler)
    }
}

#Preview {
    AppCoordinator(screenFactory: ScreenFactory(appFactory: .init()))
        .environment(\.locale, .init(identifier: "ru"))
}
