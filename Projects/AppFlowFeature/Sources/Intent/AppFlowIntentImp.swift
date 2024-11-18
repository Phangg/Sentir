//
//  AppFlowIntent.swift
//  AppFlowFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import SplashFeature

class AppFlowIntentImp {
    // Model
    private weak var model: AppFlowModelAction?
    // Dependencies
    
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
    func finishSplash() {
        model?.finishSplash()
    }
    
    //
    func completeOnboarding() {
        model?.completeFirstOnboarding()
    }
}
