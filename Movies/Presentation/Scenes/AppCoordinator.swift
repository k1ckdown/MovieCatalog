//
//  AppCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

struct AppCoordinator: View {

    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    var body: some View {
        AuthCoordinator(factory: screenFactory)
    }
}

#Preview {
    AppCoordinator(screenFactory: ScreenFactory(appFactory: .init()))
        .environment(\.locale, .init(identifier: "ru"))
}
