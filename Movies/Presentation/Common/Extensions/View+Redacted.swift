//
//  View+Redacted.swift
//  Movies
//
//  Created by Ivan Semenov on 30.10.2023.
//

import SwiftUI

extension View {
    func redacted(if condition: Bool) -> some View {
        redacted(reason: condition ? .placeholder : [])
    }
}
