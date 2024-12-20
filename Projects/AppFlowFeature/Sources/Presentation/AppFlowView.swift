//
//  AppFlowView.swift
//  AppFlowFeature
//
//  Created by phang on 11/14/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import MainTabFeature
import OnboardingFeature
import SplashFeature

public struct AppFlowView: View {
    @StateObject var container: MVIContainer<AppFlowIntent, AppFlowModelState>
    private var intent: AppFlowIntent { container.intent }
    private var state: AppFlowModelState { container.model }
    
    public init() {
        let model = AppFlowModelImp()
        let intent = AppFlowIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as AppFlowIntent,
            model: model as AppFlowModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        Group {
            switch state.currentFlow {
            case .splash:
                SplashView { [weak intent] in
                    intent?.finishSplash()
                }
            case .onboarding:
                OnboardingView { [weak intent] in
                    intent?.completeOnboarding()
                }
            case .main:
                MainTabView()
            }
        }
        .onChange(of: intent.appScheme) { _, newScheme in
            intent.updateScheme(newScheme)
        }
    }
}
