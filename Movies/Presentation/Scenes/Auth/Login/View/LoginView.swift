//
//  LoginView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Entrance")
                .font(.title2)
                .bold()
                .padding(.vertical)
            
            VStack(spacing: 30) {
                VStack(spacing: 23) {
                    TextField("", text: login)
                        .labeled("Login")
                    
                    SecureInputView(text: password)
                        .labeled("Password")
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(BaseTextFieldStyle())

                Button("Log In") {

                }
                .buttonStyle(BaseButtonStyle())
                .disabled(isLogInButtonDisabled)
            }
            
            Spacer()
            
            CalloutButton(text: "Don't have an account yet?",
                          buttonTitle: "Register") {
                
            }
        }
        .appBackground()
        .appNavigationTitle()
    }

    private var isLogInButtonDisabled: Bool {
        viewModel.state.login.isEmpty || viewModel.state.password.isEmpty
    }

    private var login: Binding<String> {
        Binding(
            get: { viewModel.state.login },
            set: { viewModel.handle(.loginChanged($0)) }
        )
    }
    
    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }
}

#Preview {
    NavigationStack {
        LoginView(viewModel: LoginViewModel())
    }
    .environment(\.locale, .init(identifier: "ru"))
}
