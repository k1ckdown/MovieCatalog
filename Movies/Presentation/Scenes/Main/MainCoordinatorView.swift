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
            home.tag(Tab.home)
            favorites.tag(Tab.favorites)
            profile.tag(Tab.profile)
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

    private var home: some View {
        HomeCoordinatorView(homeCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKey.ScreenTitle.home, systemImage: Constants.houseImage)
            }
    }

    private var favorites: some View {
        FavoritesCoordinatorView(favoritesCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKey.ScreenTitle.favorites, systemImage: Constants.heartImage)
            }
    }

    private var profile: some View {
        ProfileCoordinatorView(profileCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKey.ScreenTitle.profile, systemImage: Constants.person)
            }
    }

    private func setupTabBar() {
        UITabBar.appearance().tintColor = UIColor(resource: .appAccent)
        UITabBar.appearance().isTranslucent = true

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlack

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
