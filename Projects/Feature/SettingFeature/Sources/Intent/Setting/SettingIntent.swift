//
//  SettingIntent.swift
//  SettingFeature
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

@MainActor
protocol SettingIntent: AnyObject {
    //
    var appScheme: AppScheme { get }
    //
    func viewOnAppear()
    func completePasswordSetting()
    func completeAlarmSetting()
    func dismissPasswordSheet()
    func dismissAlarmSheet()
    func dismissSchemePicker()
    func setToggle(value: Bool, item: SettingItem)
    func setShowPasswordSheet(_ value: Bool)
    func setShowAlarmSheet(_ value: Bool)
    func setShowSchemePicker(_ value: Bool)
    func setAlarmTime(_ time: AlarmTime)
    func openSchemePicker()
}
