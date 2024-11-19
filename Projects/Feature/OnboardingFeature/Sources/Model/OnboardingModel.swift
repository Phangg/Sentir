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
    var timer: Timer? { get }
    var isTimerPaused: Bool { get }
}

// MARK: - Action
protocol OnboardingModelAction: AnyObject {
    //
    func moveToPage(_ targetViewType: OnboardingPageType)
    func getNextPage()
    func completeFirstOnboarding()
    //
    func resetTimer()
    func startTimer()
    func stopTimer()
    //
    func pauseTimer()
    func resumeTimer()
    //
    func hapticImpact()
}
