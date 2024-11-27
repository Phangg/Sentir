//
//  AlarmIntent.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

protocol AlarmIntent: AnyObject {
    //
    var setAlarmTimePublisher: AnyPublisher<AlarmTime, Never> { get }
    var finishSetAlarmPublisher: AnyPublisher<Void, Never> { get }
    var setAlarmTimeCompletion: (AlarmTime) -> Void { get }
    var finishSetAlarmCompletion: () -> Void { get }
    //
    func completeAlarmSetting()
    func updateAlarmTime(_ time: AlarmTime)
    func cleanUp()
}
