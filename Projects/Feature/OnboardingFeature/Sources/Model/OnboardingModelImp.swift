//
//  OnboardingModelImp.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine
import Common

final class OnboardingModelImp: ObservableObject, OnboardingModelState {
    @Published private(set) var currentPageType: OnboardingPageType
    @Published private(set) var progress: CGFloat
    
    init(
        currentPageType: OnboardingPageType = .a,
        progress: CGFloat = 0
    ) {
        self.currentPageType = currentPageType
        self.progress = progress
    }
}

extension OnboardingModelImp: OnboardingModelAction {
    func moveToPage(_ targetViewType: OnboardingPageType) {
        currentPageType = targetViewType
    }
    
    func updateProgress(_ progress: CGFloat) {
        self.progress = max(0, progress)
    }
    
    func resetProgress() {
        progress = 0
    }
}
