//
//  SettingView.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct SettingView: View {
    // 다크 모드 / 라이트 모드 설정
    @AppStorage("AppScheme") private var appScheme: AppScheme = .device
    @SceneStorage("ShowScenePickerView") private var showPickerView: Bool = false
    @Environment(\.colorScheme) private var scheme
    // 다크 모드 / 라이트 모드 설정
    @State private var schemePreviews: [SchemePreview] = []
    @State private var isSchemePreviewVisible: Bool = false
    @State private var overlayWindow: UIWindow?
    // 토글 설정
    @State private var toggleStates: [SettingModel: Bool] = [:]
    // 비밀번호 설정
    @State private var showPasswordSheetView: Bool = false
    @State private var didCompletePasswordSetting: Bool = false
    // 알림 시간 설정
    @State private var showAlarmSheetView: Bool = false
    @State private var didCompleteAlarmSetting: Bool = false
    @State private var alarmTime: AlarmTime = AlarmTime(timeOfDay: .pm,
                                                        hours: 6,
                                                        minutes: 0)

    public init() {
        // scheme 확인
        setWindowScheme()
    }

    public var body: some View {
        NavigationStack {
            // 스크롤 뷰
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(SettingModel.allCases, id: \.self) { item in
                        // 각 세팅 아이템
                        HStack(alignment: .center) {
                            //
                            Text(item.rawValue)
                                .textStyle(Paragraph())
                                .padding(.vertical, ViewValues.halfPadding)
                            //
                            Spacer()
                            //
                            settingItemIcon(item)
                        }
                        //
                        if item == .font || item == .restoreData || item == .feedback || item == .openSource {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 20)
                        } else {
                            CustomDivider(color: DesignSystemAsset.lightGray,
                                          type: .horizontal(height: 0.3))
                        }
                    }
                }
                .padding(ViewValues.defaultPadding)
            }
            .safeAreaPadding(.bottom, ViewValues.bottomTabArea)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar { settingViewToolbarContent() }
        }
        // 비밀번호 설정
        .sheet(isPresented: $showPasswordSheetView, onDismiss: {
            if !didCompletePasswordSetting {
                toggleStates[.lock] = false
            }
        }, content: {
            PasswordSheetView(showPasswordSheetView: $showPasswordSheetView) {
                didCompletePasswordSetting = true
            }
        })
        // 알람 설정
        .sheet(isPresented: $showAlarmSheetView, onDismiss: {
            if !didCompleteAlarmSetting {
                toggleStates[.notice] = false
            }
        }, content: {
            TimePickerView(alarmTime: $alarmTime, showAlarmSheetView: $showAlarmSheetView) {
                didCompleteAlarmSetting = true
            }
        })
        // 다크 모드 / 라이트 모드
        .sheet(isPresented: $showPickerView, onDismiss: {
            schemePreviews = []
            showPickerView = false
        }, content: {
            SchemePickerView(previews: $schemePreviews)
        })
        .onChange(of: showPickerView) { oldValue, newValue in
            if newValue {
                generateSchemwPreviews()
            } else {
                isSchemePreviewVisible = false
            }
        }
        .onAppear {
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
        .animation(.easeInOut(duration: 0.25), value: appScheme)
        //
        .tint(DesignSystemAsset.black)
    }
    
    @ViewBuilder
    private func settingItemIcon(_ item: SettingModel) -> some View {
        switch item.type {
        case .navigate:
            Button {
                // TODO: -
                switch item {
                case .displayMode:
                    showPickerView.toggle()
                case .font:
                    break
                case .deleteData:
                    break
                case .backUpData:
                    break
                case .restoreData:
                    break
                case .donation:
                    break
                case .feedback:
                    break
                case .openSource:
                    break
                default:
                    break
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.callout)
                    .padding(ViewValues.halfPadding)
            }
        case .toggle:
            HStack(alignment: .center, spacing: 20) {
                //
                if item == .notice, let notice = toggleStates[.notice], notice {
                    Text("\(alarmTime.timeOfDay.rawValue) \(String(format: "%02d", alarmTime.hours)):\(String(format: "%02d", alarmTime.minutes))")
                        .textStyle(Paragraph())
                }
                //
                Toggle("", isOn: Binding(
                    get: { toggleStates[item] ?? false },
                    set: {
                        if $0 {
                            // 잠금 설정
                            if item == .lock {
                                showPasswordSheetView = true
                            } else {
                                // 알림 설정
                                showAlarmSheetView = true
                                // TODO: -
                            }
                        } else {
                            didCompletePasswordSetting = $0
                            didCompleteAlarmSetting = $0
                        }
                        toggleStates[item] = $0
                    }
                ))
                .labelsHidden()
                .tint(DesignSystemAsset.accent)
            }
        case .text:
            Text("\(Version.getAppVersion()) (\(Version.getBuildVersion()))")
                .textStyle(Paragraph())
        }
        
    }
    
    @ToolbarContentBuilder
    fileprivate func settingViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text("설정")
                .textStyle(Title(weight: .bold))
                .padding(.horizontal, ViewValues.halfPadding)
        }
    }
    
    private func setWindowScheme() {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = appScheme == .dark ? .dark : appScheme == .light ? .light : .unspecified
        }
    }
    
    @MainActor
    private func generateSchemwPreviews() {
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow,
               schemePreviews.isEmpty {
                let size = window.screen.bounds.size
                let defaultStyle = window.overrideUserInterfaceStyle
                
                let defautSchemePreview = window.image(size)
                
                schemePreviews.append(
                    .init(
                        image: defautSchemePreview,
                        text: scheme == .dark ? AppScheme.dark.rawValue : AppScheme.light.rawValue
                    )
                )
                
                showOverlayImageView(defautSchemePreview)
                
                window.overrideUserInterfaceStyle = scheme.oppsiteInterfaceStyle
                let otherSchemePreviewImage = window.image(size)
                
                schemePreviews.append(
                    .init(
                        image: otherSchemePreviewImage,
                        text: scheme == .dark ? AppScheme.light.rawValue : AppScheme.dark.rawValue
                    )
                )
                
                if scheme == .dark { schemePreviews = schemePreviews.reversed() }
                
                window.overrideUserInterfaceStyle = defaultStyle
                try? await Task.sleep(for: .seconds(0))
                
                removeOverlayImageView()
                
                isSchemePreviewVisible = true
            }
        }
    }
    
    private func showOverlayImageView(_ image: UIImage?) {
        if overlayWindow?.rootViewController?.view.subviews.isEmpty ?? false {
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

extension ColorScheme {
    var oppsiteInterfaceStyle: UIUserInterfaceStyle {
        return self == .dark ? .light : .dark
    }
}
