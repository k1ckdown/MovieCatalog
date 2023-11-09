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
            Group {
                home.tag(Tab.home)
                favorites.tag(Tab.favorites)
                profile.tag(Tab.profile)
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color.appBlack, for: .tabBar)
        }
        .tintColor(.appAccent)
    }

    private var home: some View {
        HomeCoordinatorView(homeCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKeysConstants.ScreenTitle.home, systemImage: Constants.houseImage)
            }
    }

    private var favorites: some View {
        FavoritesCoordinatorView(favoritesCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKeysConstants.ScreenTitle.favorites, systemImage: Constants.heartImage)
            }
    }

    private var profile: some View {
        ProfileCoordinatorView(profileCoordinator, factory: factory)
            .tabItem {
                Label(LocalizedKeysConstants.ScreenTitle.profile, systemImage: Constants.person)
            }
    }

    private enum Constants {
        static let houseImage = "house"
        static let heartImage = "heart"
        static let person = "person"
    }
}
