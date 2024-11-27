//
//  SettingIntentImp.swift
//  SettingFeature
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Foundation

import Common
import Core
import Domain

@MainActor
final class SettingIntentImp {
    //
    private weak var model: SettingModelAction?
    //
    @Injected(AppSchemeUseCase.self)
    private var appSchemeUseCase: AppSchemeUseCase
    @Injected(AppSchemeUpdateService.self)
    private var appSchemeUpdateService: AppSchemeUpdateService
    // Combine
    var cancellables = Set<AnyCancellable>()
    
    //
    init(
        model: SettingModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension SettingIntentImp: SettingIntent {
    //
    var appScheme: AppScheme {
        appSchemeUseCase.currentScheme
    }
    
    //
    func viewOnAppear() {
        model?.prepareOverlayWindow()
    }
    
    func completePasswordSetting() {
        model?.updateShowPasswordSheet(false)
        model?.updateDidCompletePasswordSetting(true)
    }
    
    func completeAlarmSetting() {
        model?.updateDidCompleteAlarmSetting(true)
        model?.updateShowAlarmSheet(false)
    }
    
    func dismissPasswordSheet() {
        model?.deactivePasswordToggleState()
    }
    
    func dismissAlarmSheet() {
        model?.deactiveAlarmToggleState()
    }
    
    func dismissSchemePicker() {
        model?.updateSchemePreviews([])
        model?.updateShowSchemePicker(false)
    }
    
    func setToggle(value: Bool, item: SettingItem) {
        if value {
            if item == .lock {
                // TODO: - 잠금 설정
                model?.updateShowPasswordSheet(true)
            } else if item == .notice {
                // TODO: - 알림 설정
                model?.updateShowAlarmSheet(true)
            } else {
                fatalError("setToggle : 잠금 & 알림 외에 다른 item 값 감지")
            }
        } else {
            model?.updateDidCompletePasswordSetting(value)
            model?.updateDidCompleteAlarmSetting(value)
        }
        model?.updateToggleState(item: item, value: value)
    }
    
    func setShowPasswordSheet(_ value: Bool) {
        model?.updateShowPasswordSheet(value)
    }
    
    func setShowAlarmSheet(_ value: Bool) {
        model?.updateShowAlarmSheet(value)
    }
    
    func setShowSchemePicker(_ value: Bool) {
        model?.updateShowSchemePicker(value)
    }
    
    func setAlarmTime(_ time: AlarmTime) {
        model?.updateAlarmTime(time)
    }
    
    func openSchemePicker() {
        model?.generateSchemePreviews(currentScheme: SystemStyleHelper.currentSystemInterfaceStyle)
        Just(())
            .delay(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { [weak model] _ in
                model?.updateShowSchemePicker(true)
            }
            .store(in: &cancellables)
    }
}
