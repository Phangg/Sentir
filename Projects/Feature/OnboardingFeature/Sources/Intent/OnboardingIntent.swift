//
//  OnboardingIntent.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

@MainActor
protocol OnboardingIntent: AnyObject {
    //
    var finishOnboardingPublisher: AnyPublisher<Void, Never> { get }
    //
    func viewOnAppear()
    func viewOnDisappear()
    func moveToPage(by action: OnboardingPagingType, _ targetViewType: OnboardingPageType)
    func finishOnboarding()
    func pauseTimer()
    func resumeTimer()
}
