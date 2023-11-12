//
//  Binding+FalseBinding.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import SwiftUI

extension Binding {
    static var falseBinding: Binding<Bool> {
        Binding<Bool>(get: { false }, set: { _ in })
    }
}
