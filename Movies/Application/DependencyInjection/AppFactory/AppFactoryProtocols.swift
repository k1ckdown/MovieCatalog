//
//  AppFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

protocol ValidateEmailUseCaseFactory {
    func makeValidateEmailUseCase() -> ValidateEmailUseCase
}
