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
            AppCoordinator(screenFactory: ScreenFactory(appFactory: appFactory))
        }
    }
}
