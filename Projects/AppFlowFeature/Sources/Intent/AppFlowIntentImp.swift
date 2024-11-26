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

class AppFlowIntentImp {
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

extension AppFlowIntentImp: AppFlowIntent {
    //
    var appScheme: Common.AppScheme {
        appSchemeUseCase.currentScheme
    }
    
    //
    func updateScheme(_ scheme: Common.AppScheme) {
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
