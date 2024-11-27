//
//  AlarmModelImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

final class AlarmModelImp: ObservableObject, AlarmModelState {
    private(set) var alarmTime: AlarmTime
    
    //
    init(
        alarmTime: AlarmTime
    ) {
        self.alarmTime = alarmTime
    }
}

extension AlarmModelImp: AlarmModelAction {
    func updateAlarmTime(_ time: AlarmTime) {
        alarmTime = time
    }
}
