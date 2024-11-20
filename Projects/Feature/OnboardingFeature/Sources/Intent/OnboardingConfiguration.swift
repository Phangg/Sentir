//
//  OnboardingConfiguration.swift
//  OnboardingFeature
//
//  Created by phang on 11/20/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

public struct OnboardingConfiguration {
    let pages: [OnboardingPageType]
    let timerInterval: TimeInterval
    let totalDuration: TimeInterval
    
    public static let `default` = OnboardingConfiguration(
        pages: OnboardingPageType.allCases,
        timerInterval: 0.05,
        totalDuration: 5.0
    )
}
