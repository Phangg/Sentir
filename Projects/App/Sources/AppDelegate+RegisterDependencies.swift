//
//  AppDelegate+RegisterDependencies.swift
//  App
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common
import Core
import Data
import Domain

extension AppDelegate {
    //
    func registerDependencies() {
        let container = AppContainer.shared
        
        // AppScheme
        container.register(type: AppSchemeUseCase.self) { _ in
            AppSchemeUseCaseImp(appSchemeRepository: AppSchemeRepositoryImp())
        }
        container.register(type: AppSchemeUpdateService.self) { _ in
            AppSchemeUpdateServiceImp()
        }
        
        // TabBar State
        container.register(type: TabBarStateManageable.self) { _ in
            TabBarState()
        }
    }
}
