//
//  AppFlowModel.swift
//  AppFlowFeature
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - Enum : App Flow
public enum AppFlow: Equatable {
    case splash
    case onboarding
    case main
}

// MARK: - State
protocol AppFlowModelState {
    var currentFlow: AppFlow { get }
    var hasCompletedOnboarding: Bool { get }
}

// MARK: - Action
protocol AppFlowModelAction: AnyObject {
    func finishSplash()
    func completeFirstOnboarding()
}
