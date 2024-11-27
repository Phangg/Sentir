//
//  PasswordIntentImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Foundation

import Common

final class PasswordIntentImp {
    //
    private weak var model: PasswordModelAction?
    // OnboardingIntent Property
    var finishSetPasswordCompletion: () -> Void
    //
    private let hapticManager: HapticManager
    // Combine
    private let finishSetPasswordSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    //
    init(
        model: PasswordModelAction,
        finishSetPasswordCompletion: @escaping () -> Void,
        hapticManager: HapticManager = .shared
    ) {
        self.model = model
        self.finishSetPasswordCompletion = finishSetPasswordCompletion
        self.hapticManager = hapticManager
        //
        setupPublishers()
    }
}

// MARK: - Intent
extension PasswordIntentImp: PasswordIntent {
    //
    var finishSetPasswordPublisher: AnyPublisher<Void, Never> {
        finishSetPasswordSubject.eraseToAnyPublisher()
    }
    
    //
    func tapPasswordNumber(_ number: Int, state: PasswordSheetState) {
        guard let model = model else { fatalError("PasswordModelAction 을 찾지 못함") }
        //
        guard model.isPasswordAppendable() else { return }
        model.addPasswordNumber(number)
        //
        if model.isPasswordMaxLengthReached() {
            //
            switch state {
            case .firstSet:
                model.transitionToPasswordRecheck()
            case .recheck:
                if model.isPasswordMatching() {
                    finishSetPasswordSubject.send()
                } else {
                    model.updateIncorrectPassword(true)
                    hapticManager.triggerNotification(type: .error)
                    Just(())
                        .delay(for: .seconds(0.25), scheduler: DispatchQueue.main)
                        .sink { [weak model] _ in
                            model?.updateIncorrectPassword(false)
                        }
                        .store(in: &cancellables)
                }
            }
        }
    }
    
    func tapDeletePasswordNumber() {
        model?.removeLastPasswordNumber()
    }
    
    func finisshShakeAnimation() {
        model?.removePasswordRecheck()
    }

    func cleanUp() {
        cancellables.removeAll()
    }
}

// MARK: - setupPublishers
extension PasswordIntentImp {
    private func setupPublishers() {
        // 비밀번호 설정 완료 시
        finishSetPasswordPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.cleanUp()
                self?.finishSetPasswordCompletion()
            }
            .store(in: &cancellables)
    }
}
