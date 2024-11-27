//
//  AlarmModel.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol AlarmModelState: AnyObject {
    var alarmTime: AlarmTime { get }
}

// MARK: - Action
protocol AlarmModelAction: AnyObject {
    func updateAlarmTime(_ time: AlarmTime)
}
