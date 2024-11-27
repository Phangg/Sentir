//
//  SettingModel.swift
//  SettingFeature
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import UIKit

import Common

// MARK: - State
@MainActor
protocol SettingModelState: AnyObject {
    // 다크 모드 / 라이트 모드 설정
    var schemePreviews: [SchemePreview] { get }
    var showSchemePickerView: Bool { get }
    var overlayWindow: UIWindow? { get }
    // 토글 설정
    var toggleStates: [SettingItem: Bool] { get }
    // 비밀번호 설정
    var showPasswordSheetView: Bool { get }
    var didCompletePasswordSetting: Bool { get }
    // 알림 시간 설정
    var showAlarmSheetView: Bool { get }
    var didCompleteAlarmSetting: Bool { get }
    var alarmTime: AlarmTime { get }
    //
    var formattedAlarmTime: String { get }
    var formattedAppVersion: String { get }
}

// MARK: - Action
@MainActor
protocol SettingModelAction: AnyObject {
    //
    func updateSchemePreviews(_ previews: [SchemePreview])
    func updateAlarmTime(_ time: AlarmTime)
    func updateToggleState(item: SettingItem, value: Bool)
    func updateShowPasswordSheet(_ value: Bool)
    func updateShowAlarmSheet(_ value: Bool)
    func updateShowSchemePicker(_ value: Bool)
    func updateDidCompletePasswordSetting(_ value: Bool)
    func updateDidCompleteAlarmSetting(_ value: Bool)
    func deactivePasswordToggleState()
    func deactiveAlarmToggleState()
    func generateSchemePreviews(currentScheme: UIUserInterfaceStyle)
    func prepareOverlayWindow()
}
