//
//  ProfileView.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject private(set) var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: Constants.Form.spacing) {
            Group {
                TextField("", text: email)
                    .formBorderedTextFieldStyle()
                    .labeled(LocalizedKeysConstants.Profile.email)

                TextField("", text: avatarLink)
                    .formBorderedTextFieldStyle()
                    .labeled(LocalizedKeysConstants.Profile.email)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)

            TextField("", text: name)
                .formBorderedTextFieldStyle()
                .labeled(LocalizedKeysConstants.Profile.name)

            GenderSegmentedPicker(selection: gender)
                .labeled(LocalizedKeysConstants.Profile.gender)

            DatePickerField(date: birthdate)
                .labeled(LocalizedKeysConstants.Profile.birthdate)
        }
        .padding(.horizontal)
        .appBackground()
    }

    private enum Constants {
        enum Form {
            static let spacing: CGFloat = 12
        }
    }

    private var email: Binding<String> {
        Binding(
            get: { viewModel.state.email },
            set: { viewModel.handle(.emailChanged($0)) }
        )
    }

    private var avatarLink: Binding<String> {
        Binding(
            get: { viewModel.state.avatarLink },
            set: { viewModel.handle(.avatarLinkChanged($0)) }
        )
    }

    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
        )
    }

    private var gender: Binding<Gender> {
        Binding(
            get: { viewModel.state.gender },
            set: { viewModel.handle(.genderChanged($0)) }
        )
    }

    private var birthdate: Binding<Date> {
        Binding(
            get: { viewModel.state.birthdate },
            set: { viewModel.handle(.birthdateChanged($0)) }
        )
    }
}

#Preview {
    ProfileView(viewModel: .init())
}
