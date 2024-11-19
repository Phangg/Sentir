//
//  OnboardingIntent.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

protocol OnboardingIntent: AnyObject {
    func viewOnAppear()
    func viewOnDisappear()
    func moveToPage(by action: OnboardingPagingType, _ targetViewType: OnboardingPageType)
    func finishOnboarding()
    func handleLongPressStart()
    func handleLongPressEnd()
}
