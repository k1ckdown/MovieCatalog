//
//  SegmentedPicker.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct BaseSegmentedPicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    
    @Binding var selection: SelectionValue
    let content: () -> Content
    
    init(selection: Binding<SelectionValue>, content: @escaping () -> Content) {
        _selection = selection
        self.content = content
        updateAppearance()
    }
    
    var body: some View {
        Picker("", selection: $selection) {
            content()
        }
        .labelsHidden()
        .pickerStyle(.segmented)
    }
    
    func updateAppearance() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
    }
}
