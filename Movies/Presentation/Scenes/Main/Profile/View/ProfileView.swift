//
//  ProfileView.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.contentSpacing) {
                VStack {
                    AvatarAsyncImage(
                        size: Constants.profileImageSize,
                        urlString: viewModel.state.avatarLink
                    )

                    Text(viewModel.state.username)
                        .font(.title2)
                        .bold()

                    Button(LocalizedKey.Auth.Action.logOut) {
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
                            .smallLabeled(LocalizedKey.Profile.email)

                        TextField("", text: avatarLink)
                            .formErrorableItem(
                                message: viewModel.state.avatarLinkError,
                                isErrorShowed: viewModel.state.isAvatarLinkErrorShowing
                            )
                            .smallLabeled(LocalizedKey.Profile.avatarLink)
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                    TextField("", text: name)
                        .formBorderedTextFieldStyle()
                        .smallLabeled(LocalizedKey.Profile.name)

                    GenderSegmentedPicker(selection: gender)
                        .smallLabeled(LocalizedKey.Profile.gender)

                    DatePickerField(date: birthdate)
                        .smallLabeled(LocalizedKey.Profile.birthdate)
                }
                .padding(.horizontal)

                if viewModel.state.isUpdating {
                    ProgressView()
                        .tint(.appAccent)
                } else {
                    VStack(spacing: Constants.buttonSpacing) {
                        Button(LocalizedKey.Profile.save) {
                            viewModel.handle(.saveTapped)
                        }
                        .baseButtonStyle()
                        .disabled(viewModel.state.isSaveDisabled)

                        Button(LocalizedKey.Profile.cancel) {
                            viewModel.handle(.cancelTapped)
                        }
                        .baseButtonStyle(isProminent: false)
                        .disabled(!viewModel.state.isDataChanged)
                    }
                    .padding()
                }
            }
            .padding(.top)
        }
        .scrollIndicators(.hidden)
        .backgroundColor()
        .alert(LocalizedKey.ErrorMessage.error, isPresented: isAlertPresented) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(viewModel.state.errorMessage)
        }
        .onAppear {
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
            get: { viewModel.state.newAvatarLink },
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
