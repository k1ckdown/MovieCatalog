//
//  MoviesApp.swift
//  Movies
//
//  Created by Ivan Semenov on 14.10.2023.
//

import SwiftUI

@main
struct MoviesApp: App {

    private let appFactory = AppFactory()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                screenFactory: ScreenFactory(appFactory: appFactory),
                coordinator: AppCoordinator(
                    fetchProfileUseCase: appFactory.makeFetchProfileUseCase(),
                    fetchFavoriteMoviesUseCase: appFactory.makeFetchFavoriteMoviesUseCase()
                )
            )
            .preferredColorScheme(.dark)
            .onAppear {
                NetworkMonitor.shared.startMonitoring()
            }
        }
    }
}
