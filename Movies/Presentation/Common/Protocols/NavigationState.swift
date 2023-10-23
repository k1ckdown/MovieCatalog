//
//  NavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

@MainActor
protocol NavigationState: ObservableObject where Screen: Routable {
    associatedtype Screen
    var path: NavigationPath { get }
}
