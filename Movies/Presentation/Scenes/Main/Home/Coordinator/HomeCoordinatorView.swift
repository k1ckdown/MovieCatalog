//
//  HomeCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

struct HomeCoordinatorView: View {
    
    private let rootView: HomeView
    private let factory: HomeCoordinatorFactory
    @ObservedObject private var coordinator: HomeCoordinator
    
    init(_ coordinator: HomeCoordinator, factory: HomeCoordinatorFactory) {
        self.factory = factory
        self.coordinator = coordinator
        rootView = factory.makeHomeView(coordinator: coordinator)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            rootView
                .navigationDestination(for: HomeCoordinator.Screen.self, destination: destination)
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: HomeCoordinator.Screen) -> some View {
        switch screen {
        case .movieDetails(let movieDetails):
            factory.makeMovieDetailsView(movieDetails: movieDetails)
        }
    }
}