//
//  RegistrationView.swift
//  Movies
//
//  Created by Ivan Semenov on 19.10.2023.
//

import SwiftUI

struct RegistrationView<ViewModel: RegistrationViewModelProtocol>: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            ScreenTitle(text: "Registration")

            Form {
                Group {
                    Section {
                        TextField("", text: name)
                    } header: {
                        AuthFormHeader(title: "Name")
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .textFieldStyle(BaseTextFieldStyle())
            }
            .scrollContentBackground(.hidden)
            .padding(.horizontal, -3)
        }
        .appBackground()
        .appNavigationTitle()
    }

    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
        )
    }
}

#Preview {
    NavigationStack {
        RegistrationView(viewModel: RegistrationViewModel())
            .environment(\.locale, .init(identifier: "ru"))
    }
}
