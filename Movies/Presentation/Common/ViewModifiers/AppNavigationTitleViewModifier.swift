//
//  AppNavigationTitleViewModifier.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct AppNavigationTitleViewModifier: ViewModifier {
    
    init() {
        let uiColor = UIColor(.appAccent)
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("FИЛЬМУС")
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func appNavigationTitle() -> some View {
        modifier(AppNavigationTitleViewModifier())
    }
}
