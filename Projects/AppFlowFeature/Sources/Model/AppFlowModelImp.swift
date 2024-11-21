//
//  AppFlowModelImp.swift
//  AppFlowFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import Combine

import Data

public final class AppFlowModelImp: ObservableObject, AppFlowModelState {
    //
    @Published var currentFlow: AppFlow = .splash
    var hasCompletedOnboarding: Bool
    //
    private let storage: StorageType
    private let onboardingKey = "hasCompletedOnboarding"
    
    //
    init(
        hasCompletedOnboarding: Bool = false,
        storage: StorageType = UserDefaults.standard
    ) {
        self.hasCompletedOnboarding = storage.getValue(forKey: onboardingKey) ?? hasCompletedOnboarding
        self.storage = storage
    }
}

extension AppFlowModelImp: AppFlowModelAction {
    func finishSplash() {
        currentFlow = hasCompletedOnboarding ? .main : .onboarding
    }
    
    func completeFirstOnboarding() {
        hasCompletedOnboarding = true
        storage.setValue(true, forKey: onboardingKey)
        currentFlow = .main
    }
}
