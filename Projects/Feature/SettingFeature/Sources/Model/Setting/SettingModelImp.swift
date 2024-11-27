//
//  SettingModelImp.swift
//  SettingFeature
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine

import Common

@MainActor
final class SettingModelImp: ObservableObject, SettingModelState {
    // 다크 모드 / 라이트 모드 설정
    @Published private(set) var schemePreviews: [SchemePreview]
    @Published private(set) var showSchemePickerView: Bool
    @Published private(set) var overlayWindow: UIWindow?
    // 토글 설정
    @Published private(set) var toggleStates: [SettingItem : Bool]
    // 비밀번호 설정
    @Published private(set) var showPasswordSheetView: Bool
    @Published private(set) var didCompletePasswordSetting: Bool
    // 알림 시간 설정
    @Published private(set) var showAlarmSheetView: Bool
    @Published private(set) var didCompleteAlarmSetting: Bool
    @Published private(set) var alarmTime: AlarmTime
    //
    private(set) var formattedAlarmTime: String
    private(set) var formattedAppVersion: String
    
    //
    init(
        schemePreviews: [SchemePreview] = [],
        showSchemePickerView: Bool = false,
        overlayWindow: UIWindow? = nil,
        toggleStates: [SettingItem : Bool] = [:],
        showPasswordSheetView: Bool = false,
        didCompletePasswordSetting: Bool = false,
        showAlarmSheetView: Bool = false,
        didCompleteAlarmSetting: Bool = false,
        alarmTime: AlarmTime = AlarmTime(timeOfDay: .pm, hours: 6, minutes: 0)
    ) {
        self.schemePreviews = schemePreviews
        self.showSchemePickerView = showSchemePickerView
        self.overlayWindow = overlayWindow
        self.toggleStates = toggleStates
        self.showPasswordSheetView = showPasswordSheetView
        self.didCompletePasswordSetting = didCompletePasswordSetting
        self.showAlarmSheetView = showAlarmSheetView
        self.didCompleteAlarmSetting = didCompleteAlarmSetting
        self.alarmTime = alarmTime
        //
        self.formattedAlarmTime = "\(alarmTime.timeOfDay.rawValue) \(String(format: "%02d", alarmTime.hours)):\(String(format: "%02d", alarmTime.minutes))"
        self.formattedAppVersion = "\(VersionHelper.getAppVersion()) (\(VersionHelper.getBuildVersion()))"
    }
    
    //
    private func showOverlayImageView(_ image: UIImage?) {
        removeOverlayImageView()
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            overlayWindow?.rootViewController?.view.addSubview(imageView)
        }
    }
    
    private func removeOverlayImageView() {
        overlayWindow?.rootViewController?.view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

extension SettingModelImp: SettingModelAction {
    func updateSchemePreviews(_ previews: [SchemePreview]) {
        schemePreviews = previews
    }
    
    func updateAlarmTime(_ time: AlarmTime) {
        alarmTime = time
        formattedAlarmTime = "\(alarmTime.timeOfDay.rawValue) \(String(format: "%02d", alarmTime.hours)):\(String(format: "%02d", alarmTime.minutes))"
    }
    
    func updateToggleState(item: SettingItem, value: Bool) {
        toggleStates[item] = value
    }
    
    func updateShowPasswordSheet(_ value: Bool) {
        showPasswordSheetView = value
    }
    
    func updateShowAlarmSheet(_ value: Bool) {
        showAlarmSheetView = value
    }
    
    func updateShowSchemePicker(_ value: Bool) {
        showSchemePickerView = value
    }
    
    func updateDidCompletePasswordSetting(_ value: Bool) {
        didCompletePasswordSetting = value
    }
    
    func updateDidCompleteAlarmSetting(_ value: Bool) {
        didCompleteAlarmSetting = value
    }
    
    func deactivePasswordToggleState() {
        if !didCompletePasswordSetting {
            toggleStates[.lock] = false
        }
    }
    
    func deactiveAlarmToggleState() {
        if !didCompleteAlarmSetting {
            toggleStates[.notice] = false
        }
    }
    
    func generateSchemePreviews(currentScheme: UIUserInterfaceStyle) {
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow,
               schemePreviews.isEmpty {
                let size = window.screen.bounds.size
                let defaultStyle = window.overrideUserInterfaceStyle
                
                // 현재 스키마 이미지
                let defautSchemePreview = window.image(size)
                schemePreviews.append(
                    .init(
                        image: defautSchemePreview,
                        text: currentScheme == .dark ? AppScheme.dark.rawValue : AppScheme.light.rawValue
                    )
                )
                // overlayWindow 에 이미지 표시
                showOverlayImageView(defautSchemePreview)
                
                // 반대 스키마로 변경
                window.overrideUserInterfaceStyle = currentScheme.oppsiteInterfaceStyle
                
                // 반대 스키마 이미지
                let otherSchemePreviewImage = window.image(size)
                schemePreviews.append(
                    .init(
                        image: otherSchemePreviewImage,
                        text: currentScheme == .dark ? AppScheme.light.rawValue : AppScheme.dark.rawValue
                    )
                )
                
                // 다크모드의 경우 순서 바꾸기
                if currentScheme == .dark {
                    schemePreviews = schemePreviews.reversed()
                }
                
                // 스키마 복구
                window.overrideUserInterfaceStyle = defaultStyle
                try? await Task.sleep(for: .seconds(0))
                
                // overlayWindow 에 이미지 제거
                removeOverlayImageView()
            }
        }
    }
    
    func prepareOverlayWindow() {
        if let scene = (UIApplication.shared.connectedScenes.first as? UIWindowScene),
           overlayWindow == nil {
            
            let window = UIWindow(windowScene: scene)
            window.backgroundColor = .clear
            window.isHidden = false
            window.isUserInteractionEnabled = false
            
            let emptyController = UIViewController()
            emptyController.view.backgroundColor = .clear
            
            window.rootViewController = emptyController
            
            overlayWindow = window
        }
    }
}
