//
//  MainCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 03.11.2023.
//

import SwiftUI

struct MainCoordinatorView: View {

    private let factory: ScreenFactory
    private let homeCoordinator = HomeCoordinator()
    private let profileCoordinator = ProfileCoordinator()
    private let favoritesCoordinator = FavoritesCoordinator()

    @ObservedObject private var mainCoordinator: MainCoordinator

    init(_ mainCoordinator: MainCoordinator, factory: ScreenFactory) {
        self.factory = factory
        self.mainCoordinator = mainCoordinator
    }

    var body: some View {
        TabView(selection: $mainCoordinator.selectedTab) {
            Group {
                HomeCoordinatorView(homeCoordinator, factory: factory)
                    .tabItem {
                        Label(LocalizedKeysConstants.ScreenTitle.home, systemImage: Constants.houseImage)
                    }
                    .tag(MainCoordinator.Tab.home)

                FavoritesCoordinatorView(favoritesCoordinator, factory: factory)
                    .tabItem {
                        Label(LocalizedKeysConstants.ScreenTitle.favorites, systemImage: Constants.heartImage)
                    }
                    .tag(MainCoordinator.Tab.favorites)

                ProfileCoordinatorView(profileCoordinator, factory: factory)
                    .tabItem {
                        Label(LocalizedKeysConstants.ScreenTitle.profile, systemImage: Constants.person)
                    }
                    .tag(MainCoordinator.Tab.profile)
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color.background, for: .tabBar)
        }
        .tintColor(.appAccent)
    }

    private enum Constants {
        static let houseImage = "house"
        static let heartImage = "heart"
        static let person = "person"
    }
}
