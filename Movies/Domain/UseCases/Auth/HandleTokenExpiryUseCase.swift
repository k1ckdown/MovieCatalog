//
//  HandleTokenExpiryUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 09.11.2023.
//

import Foundation

final class HandleTokenExpiryUseCase {

    private let profileRepository: ProfileRepositoryProtocol
    private let keychainRepository: KeychainRepositoryProtocol

    init(
        profileRepository: ProfileRepositoryProtocol,
        keychainRepository: KeychainRepositoryProtocol
    ) {
        self.profileRepository = profileRepository
        self.keychainRepository = keychainRepository
    }

    func execute() throws {
        try keychainRepository.deleteToken()
        profileRepository.removeLocalProfile()
    }
}
