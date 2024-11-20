//
//  OnboardingIntentImp.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import SwiftUI

@MainActor
final class OnboardingIntentImp {
    //
    private weak var model: OnboardingModelAction?
    private let configuration: OnboardingConfiguration
    //
    private var timerCancellable: AnyCancellable?
    private var isTimerPaused: Bool = false
    // Combine
    private let finishOnboardingSubject = PassthroughSubject<Void, Never>()
    private let pageTransitionSubject = PassthroughSubject<Void, Never>()
    private let indicatorTransitionSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    //
    init(
        model: OnboardingModelAction,
        configuration: OnboardingConfiguration
    ) {
        self.model = model
        self.configuration = configuration
        //
        setupPublishers()
    }
    
    //
    private func setupPublishers() {
        //
        pageTransitionSubject
            .delay(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.startTimer()
            }
            .store(in: &cancellables)
        //
        indicatorTransitionSubject
            .delay(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.resetTimer()
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {
        guard timerCancellable == nil, !isTimerPaused else { return }
        timerCancellable = Timer.publish(every: configuration.timerInterval, on: .main, in: .common)
            .autoconnect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // TODO: - 에러 체크 수정 (해당 메서드 외에도 에러 체크 고려)
                    fatalError("Onboarding - startTimer \n\(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                self?.handleTimerProgress()
            })
    }
    
    private func handleTimerProgress() {
        let progressIncrement = CGFloat(configuration.timerInterval / configuration.totalDuration)
        if let currentProgress = (model as? OnboardingModelState)?.progress {
            if currentProgress >= 1 {
                showNextPage()
            } else {
                model?.updateProgress(currentProgress + progressIncrement)
            }
        }
    }
    
    private func showNextPage() {
        if let currentPage = (model as? OnboardingModelState)?.currentPageType {
            let pages = configuration.pages
            guard let currentIndex = pages.firstIndex(of: currentPage) else { return }
            if currentIndex == pages.count - 1 {
                finishOnboarding()
            } else {
                model?.moveToPage(pages[currentIndex + 1])
            }
        }
        resetTimer()
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        model?.resetProgress()
    }
    
    private func resetTimer() {
        stopTimer()
        guard !isTimerPaused else { return }
        pageTransitionSubject.send()
    }
    
    func cleanUp() {
        cancellables.removeAll()
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

extension OnboardingIntentImp: OnboardingIntent {
    var finishOnboardingPublisher: AnyPublisher<Void, Never> {
        finishOnboardingSubject.eraseToAnyPublisher()
    }
    
    //
    func viewOnAppear() {
        startTimer()
    }
    
    func viewOnDisappear() {
        stopTimer()
    }
    
    func moveToPage(by action: OnboardingPagingType, _ targetViewType: OnboardingPageType) {
        model?.moveToPage(targetViewType)
        switch action {
        case .scroll:
            indicatorTransitionSubject.send()
        case .indicatorTap:
            resetTimer()
        }
    }
    
    func finishOnboarding() {
        finishOnboardingSubject.send()
    }
    
    func pauseTimer() {
        guard !isTimerPaused else { return }
        isTimerPaused = true
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func resumeTimer() {
        guard isTimerPaused else { return }
        isTimerPaused = false
        startTimer()
    }
}
