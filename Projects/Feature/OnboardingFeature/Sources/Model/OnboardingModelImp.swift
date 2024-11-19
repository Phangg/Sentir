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

public final class OnboardingModelImp: ObservableObject, OnboardingModelState {
    //
    @Published var currentPageType: OnboardingPageType
    @Published var progress: CGFloat
    @Published var timer: Timer?
    @Published var isTimerPaused: Bool
    
    // Combine
    private let finishOnboardingSubject = PassthroughSubject<Void, Never>()
    private let pageTransitionSubject = PassthroughSubject<OnboardingPageType, Never>()

    var finishOnboardingPublisher: AnyPublisher<Void, Never> {
        finishOnboardingSubject.eraseToAnyPublisher()
    }
    
    var cancellables = Set<AnyCancellable>()

    //
    init(
        currentPageType: OnboardingPageType = .a,
        progress: CGFloat = 0,
        isTimerPaused: Bool = false
    ) {
        self.currentPageType = currentPageType
        self.progress = progress
        self.isTimerPaused = isTimerPaused
        //
        setupPageTransition()
    }
    
    private func setupPageTransition() {
        pageTransitionSubject
            .delay(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.startTimer()
            }
            .store(in: &cancellables)
    }
}

extension OnboardingModelImp: OnboardingModelAction {
    func moveToPage(_ targetViewType: OnboardingPageType) {
        currentPageType = targetViewType
    }

    func getNextPage() {
        switch currentPageType {
        case .a:
            currentPageType = .b
        case .b:
            currentPageType = .c
        default:
            fatalError("OnboardingView - 마지막 온보딩에서 동작하면 안되는 메서드 동작")
        }
    }
    
    func completeFirstOnboarding() {
        print("Onboarding - 온보딩 완료")
        finishOnboardingSubject.send()
    }
    
    //
    func resetTimer() {
        stopTimer()
        guard !isTimerPaused else { return }
        pageTransitionSubject.send(currentPageType)
    }
    
    func startTimer() {
        guard !isTimerPaused else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            withAnimation(.linear(duration: 0.05)) {
                self.progress += (0.05 / 5)
                if self.progress >= 1 {
                    self.getNextPage()
                    self.resetTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        progress = 0
    }
    
    func pauseTimer() {
        guard !isTimerPaused else { return }
        isTimerPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func resumeTimer() {
        guard isTimerPaused else { return }
        isTimerPaused = false
        startTimer()
    }
    
    func hapticImpact() {
        HapticManager.shared.triggerImpact(style: .medium)
    }
}
