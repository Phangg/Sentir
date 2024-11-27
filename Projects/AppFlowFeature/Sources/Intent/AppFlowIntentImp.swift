//
//  AppFlowIntent.swift
//  AppFlowFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Common
import Core
import Domain
import SplashFeature

final class AppFlowIntentImp {
    // Model
    private weak var model: AppFlowModelAction?
    // Dependencies
    @Injected(AppSchemeUseCase.self)
    private var appSchemeUseCase: AppSchemeUseCase
    @Injected(AppSchemeUpdateService.self)
    private var appSchemeUpdateService: AppSchemeUpdateService
    // Business Data

    //
    init(
        model: AppFlowModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension AppFlowIntentImp: AppFlowIntent {
    //
    var appScheme: AppScheme {
        appSchemeUseCase.currentScheme
    }
    
    //
    func updateScheme(_ scheme: AppScheme) {
        appSchemeUseCase.updateScheme(scheme)
        appSchemeUpdateService.updateAppearance(scheme)
    }
    
    func finishSplash() {
        model?.finishSplash()
    }
    
    func completeOnboarding() {
        model?.completeFirstOnboarding()
    }
}
