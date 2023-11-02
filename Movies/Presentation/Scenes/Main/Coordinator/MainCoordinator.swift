//
//  MainCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class MainCoordinator: ObservableObject {
    
    enum Tab {
        case home
        case favorites
        case profile
    }

    @Published var selectedTab = Tab.home
}
