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
                AvatarAsyncImage(link: viewModel.state.avatarLink)

                Text(viewModel.state.username)
                    .font(.title2)
                    .bold()
            }

            VStack(spacing: Constants.formSpacing) {
                Group {
                    TextField("", text: email)
                        .formErrorableItem(
                            message: viewModel.state.emailError,
                            isErrorShowed: viewModel.state.isEmailErrorShowing
                        )
                        .labeled(LocalizedKeysConstants.Profile.email)

                    TextField("", text: avatarLink)
                        .formErrorableItem(
                            message: viewModel.state.avatarLinkError,
                            isErrorShowed: viewModel.state.isAvatarLinkErrorShowing
                        )
                        .labeled(LocalizedKeysConstants.Profile.avatarLink)
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

            VStack(spacing: Constants.buttonSpacing) {
                Button(LocalizedKeysConstants.Profile.save) {

                }
                .baseButtonStyle()
                .disabled(viewModel.state.isSaveDisabled)

                Button(LocalizedKeysConstants.Profile.cancel) {

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
        .onAppear {
            viewModel.handle(.onAppear)
        }
    }

    private enum Constants {
        static let formSpacing: CGFloat = 15
        static let buttonSpacing: CGFloat = 17
        static let contentSpacing: CGFloat = 18
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
    ProfileView(viewModel:
            .init(
                getProfileUseCase: .init(profileRepository: ProfileRepository(networkService: NetworkService())),
                updateProfileUseCase: .init(secureStorage: SecureStorage(), profileRepository: ProfileRepository(networkService: NetworkService())),
                validateEmailUseCase: .init()
            )
    )
}
