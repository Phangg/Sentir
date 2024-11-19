//
//  OnboardingIntentImp.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

class OnboardingIntentImp {
    // Model
    private weak var model: OnboardingModelAction?
    // Dependencies

    // Business Data

    
    //
    init(
        model: OnboardingModelAction
    ) {
        self.model = model
    }
}

extension OnboardingIntentImp: OnboardingIntent {
    func viewOnAppear() {
        model?.startTimer()
    }
    
    func viewOnDisappear() {
        model?.stopTimer()
    }
    
    func moveToPage(by action: OnboardingPagingType, _ targetViewType: OnboardingPageType) {
        model?.moveToPage(targetViewType)
        switch action {
        case .scroll:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.model?.resetTimer()
            }
        case .indicatorTap:
            model?.resetTimer()
        }
    }
    
    func finishOnboarding() {
        model?.completeFirstOnboarding()
    }
    
    func handleLongPressStart() {
        model?.hapticImpact()
        model?.pauseTimer()
    }
    
    func handleLongPressEnd() {
        model?.resumeTimer()
    }
}
