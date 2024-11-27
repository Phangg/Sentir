//
//  AlarmIntentImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Foundation

final class AlarmIntentImp {
    //
    private weak var model: AlarmModelAction?
    // AlarmIntent Property
    var setAlarmTimeCompletion: (AlarmTime) -> Void
    var finishSetAlarmCompletion: () -> Void
    // Combine
    private let setAlarmTimeSubject = PassthroughSubject<AlarmTime, Never>()
    private let finishSetAlarmSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    //
    init(
        model: AlarmModelAction,
        setAlarmTimeCompletion: @escaping (AlarmTime) -> Void,
        finishSetAlarmCompletion: @escaping () -> Void
    ) {
        self.model = model
        self.setAlarmTimeCompletion = setAlarmTimeCompletion
        self.finishSetAlarmCompletion = finishSetAlarmCompletion
    }
}

// MARK: - Intent
extension AlarmIntentImp: AlarmIntent {
    //
    var setAlarmTimePublisher: AnyPublisher<AlarmTime, Never> {
        setAlarmTimeSubject.eraseToAnyPublisher()
    }
    
    var finishSetAlarmPublisher: AnyPublisher<Void, Never> {
        finishSetAlarmSubject.eraseToAnyPublisher()
    }
    
    //
    func completeAlarmSetting() {
        finishSetAlarmSubject.send()
        // TODO: -
    }
    
    func updateAlarmTime(_ time: AlarmTime) {
        setAlarmTimeSubject.send(time)
        model?.updateAlarmTime(time)
    }

    func cleanUp() {
        cancellables.removeAll()
    }
}

// MARK: - setupPublishers
extension AlarmIntentImp {
    private func setupPublishers() {
        // 알람 시간 변경 시
        setAlarmTimePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: setAlarmTimeCompletion)
            .store(in: &cancellables)
        // 알람 설정 완료 시
        finishSetAlarmPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.cleanUp()
                self?.finishSetAlarmCompletion()
            }
            .store(in: &cancellables)
    }
}
