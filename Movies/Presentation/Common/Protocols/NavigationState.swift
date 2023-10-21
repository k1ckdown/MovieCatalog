//
//  NavigationState.swift
//  Movies
//
//  Created by Ivan Semenov on 21.10.2023.
//

import SwiftUI

@MainActor
protocol NavigationState: ObservableObject where Screen: RouteLink {
    associatedtype Screen
    associatedtype Action

    var path: NavigationPath { get }
    func execute(_ action: Action)
}
