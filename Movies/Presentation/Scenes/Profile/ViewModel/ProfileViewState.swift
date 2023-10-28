//
//  ProfileViewState.swift
//  Movies
//
//  Created by Ivan Semenov on 29.10.2023.
//

import Foundation

struct ProfileViewState: Equatable {
    var username = ""
    var email = ""
    var avatarLink = ""
    var name = ""
    var gender = Gender.male
    var birthdate = Date.now

    var loadError: String?
    var emailError: String?
    var avatarLinkError: String?
    var isDataChanged = false

    var isEmailErrorShowing: Bool {
        email.isEmpty == false && emailError != nil
    }

    var isAvatarLinkErrorShowing: Bool {
        avatarLink.isEmpty == false && avatarLinkError != nil
    }

    var isSaveDisabled: Bool {
        email.isEmpty || avatarLink.isEmpty ||
        name.isEmpty || emailError != nil || isDataChanged == false
    }
}

enum ProfileViewEvent {
    case onAppear
    case onTapEdit
    case onTapSave
    case onTapLogOut

    case emailChanged(String)
    case avatarLinkChanged(String)
    case nameChanged(String)
    case genderChanged(Gender)
    case birthdateChanged(Date)
}
