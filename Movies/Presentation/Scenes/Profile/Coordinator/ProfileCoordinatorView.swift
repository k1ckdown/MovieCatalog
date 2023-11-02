//
//  ProfileCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct ProfileCoordinatorView: View {

    private let factory: ScreenFactory
    @ObservedObject private(set) var coordinator: ProfileCoordinator

    init(factory: ScreenFactory, coordinator: ProfileCoordinator) {
        self.factory = factory
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            EmptyView()
        }
    }
}
