//
//  ProfileCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import SwiftUI

struct ProfileCoordinatorView: View {

    private let factory: ProfileCoordinatorFactory
    @ObservedObject private var coordinator: ProfileCoordinator
    
    init(_ coordinator: ProfileCoordinator, factory: ProfileCoordinatorFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeProfileView(coordinator: coordinator)
        }
    }
}
