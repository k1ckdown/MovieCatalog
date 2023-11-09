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
        VStack(spacing: Constants.contentSpacing) {
            VStack {
                AvatarAsyncImage(
                    size: Constants.profileImageSize,
                    urlString: viewModel.state.avatarLink
                )

                Text(viewModel.state.username)
                    .font(.title2)
                    .bold()

                Button(LocalizedKeysConstants.Auth.Action.logOut) {
                    viewModel.handle(.logOutTapped)
                }
                .fontWeight(.semibold)
                .foregroundStyle(.appAccent)
                .padding(.top, Constants.logOutTopInset)
            }

            VStack(spacing: Constants.formSpacing) {
                Group {
                    TextField("", text: email)
                        .formErrorableItem(
                            message: viewModel.state.emailError,
                            isErrorShowed: viewModel.state.isEmailErrorShowing
                        )
                        .smallLabeled(LocalizedKeysConstants.Profile.email)

                    TextField("", text: avatarLink)
                        .formErrorableItem(
                            message: viewModel.state.avatarLinkError,
                            isErrorShowed: viewModel.state.isAvatarLinkErrorShowing
                        )
                        .smallLabeled(LocalizedKeysConstants.Profile.avatarLink)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

                TextField("", text: name)
                    .formBorderedTextFieldStyle()
                    .smallLabeled(LocalizedKeysConstants.Profile.name)

                GenderSegmentedPicker(selection: gender)
                    .smallLabeled(LocalizedKeysConstants.Profile.gender)

                DatePickerField(date: birthdate)
                    .smallLabeled(LocalizedKeysConstants.Profile.birthdate)
            }
            .padding(.horizontal)

            VStack(spacing: Constants.buttonSpacing) {
                Button(LocalizedKeysConstants.Profile.save) {
                    viewModel.handle(.saveTapped)
                }
                .baseButtonStyle()
                .disabled(viewModel.state.isSaveDisabled)

                Button(LocalizedKeysConstants.Profile.cancel) {
                    viewModel.handle(.cancelTapped)
                }
                .baseButtonStyle(isProminent: false)
            }
            .padding()

            Spacer()
        }
        .appBackground()
        .alert(LocalizedKeysConstants.ErrorMessage.error, isPresented: isAlertPresented) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(viewModel.state.errorMessage)
        }
        .firstAppear {
            viewModel.handle(.onAppear)
        }
    }

    private enum Constants {
        static let logOutTopInset: CGFloat = 1

        static let formSpacing: CGFloat = 15
        static let buttonSpacing: CGFloat = 17
        static let contentSpacing: CGFloat = 18
        static let profileImageSize: CGFloat = 80
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

    private var isAlertPresented: Binding<Bool> {
        Binding(
            get: { viewModel.state.isAlertPresenting },
            set: { viewModel.handle(.onAlertPresented($0)) }
        )
    }
}

#Preview {
    ScreenFactory(appFactory: .init()).makeProfileView(coordinator: ProfileCoordinator(showAuthSceneHandler: {}))
}
