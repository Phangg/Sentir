//
//  OnboardingModel.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

// MARK: - State
protocol OnboardingModelState {
    var currentPageType: OnboardingPageType { get }
    var progress: CGFloat { get }
}

// MARK: - Action
protocol OnboardingModelAction: AnyObject {
    func moveToPage(_ targetViewType: OnboardingPageType)
    func updateProgress(_ progress: CGFloat)
    func resetProgress()
}
