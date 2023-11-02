//
//  ProfileCoordinator.swift
//  Movies
//
//  Created by Ivan Semenov on 02.11.2023.
//

import Foundation

final class ProfileCoordinator: Coordinator {

    enum Screen: Routable {

    }

    @Published var navigationPath = [Screen]()
}
