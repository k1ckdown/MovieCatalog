//
//  MainCoordinatorView.swift
//  Movies
//
//  Created by Ivan Semenov on 03.11.2023.
//

import SwiftUI

struct MainCoordinatorView: View {

    enum Tab {
        case home
        case favorites
        case profile
    }

    @State private var selectedTab = Tab.home

    private let factory: ScreenFactory
    private let homeCoordinator: HomeCoordinator
    private let profileCoordinator: ProfileCoordinator
    private let favoritesCoordinator: FavoritesCoordinator

    init(factory: ScreenFactory, showAuthSceneHandler: @escaping () -> Void) {
        self.factory = factory

        homeCoordinator = .init(showAuthSceneHandler: showAuthSceneHandler)
        profileCoordinator = .init(showAuthSceneHandler: showAuthSceneHandler)
        favoritesCoordinator = .init(showAuthSceneHandler: showAuthSceneHandler)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeCoordinatorView(homeCoordinator, factory: factory)
                .tabItem {
                    Label(LocalizedKey.TabTitle.home, systemImage: Constants.houseImage)
                }
                .tag(Tab.home)

            FavoritesCoordinatorView(favoritesCoordinator, factory: factory)
                .tabItem {
                    Label(LocalizedKey.TabTitle.favorites, systemImage: Constants.heartImage)
                }
                .tag(Tab.favorites)

            ProfileCoordinatorView(profileCoordinator, factory: factory)
                .tabItem {
                    Label(LocalizedKey.TabTitle.profile, systemImage: Constants.person)
                }
                .tag(Tab.profile)
        }
        .tintColor(.appAccent)
        .onAppear {
            setupTabBar()
        }
    }

    private enum Constants {
        static let houseImage = "house"
        static let heartImage = "heart"
        static let person = "person"
    }

    @MainActor private func setupTabBar() {
        UITabBar.appearance().tintColor = UIColor(resource: .appAccent)
        UITabBar.appearance().isTranslucent = true

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlack

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
