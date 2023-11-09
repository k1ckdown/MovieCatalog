//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppCoordinatorView: View {

    private let screenFactory: ScreenFactory
    @ObservedObject private var coordinator: AppCoordinator

    init(screenFactory: ScreenFactory, coordinator: AppCoordinator) {
        self.screenFactory = screenFactory
        self.coordinator = coordinator
    }

    var body: some View {
        sceneView
            .onAppear {
                coordinator.handle(.checkProfile)
            }
    }

    @ViewBuilder
    private var sceneView: some View {
        switch coordinator.state {
        case .idle:
            EmptyView()

        case .loading:
            ProgressView()
                .tint(.appAccent)
                .appBackground()

        case .auth:
            AuthCoordinatorView(
                AuthCoordinator(showMainSceneHandler: { coordinator.handle(.showMain) }),
                factory: screenFactory
            )

        case .main:
            MainCoordinatorView(
                factory: screenFactory,
                showAuthSceneHandler: { coordinator.handle(.showAuth) }
            )
        }
    }
}

#Preview {
    let appFactory = AppFactory()
    return AppCoordinatorView(
        screenFactory: ScreenFactory(appFactory: appFactory),
        coordinator: AppCoordinator(fetchProfileUseCase: appFactory.makeFetchProfileUseCase())
    )
    .environment(\.locale, .init(identifier: "ru"))
}
