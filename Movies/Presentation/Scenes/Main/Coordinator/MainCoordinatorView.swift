//
//  MainCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct MainCoordinatorView: View {
    
    private let mainView: MainView
    private let factory: MainCoordinatorFactory
    @ObservedObject private var coordinator: MainCoordinator
    
    init(_ coordinator: MainCoordinator, factory: MainCoordinatorFactory) {
        self.factory = factory
        self.coordinator = coordinator
        mainView = factory.makeMainView(coordinator: coordinator)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            mainView
                .navigationDestination(for: MainCoordinator.Screen.self, destination: destination)
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: MainCoordinator.Screen) -> some View {
        switch screen {
        case .movieDetails(let movieDetails):
            factory.makeMovieDetailsView(movieDetails: movieDetails)
        }
    }
}
