//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {
    
}

extension AppFactory {
    
    func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        ValidateEmailUseCase()
    }
    
}
