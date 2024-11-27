//
//  SettingView.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

public struct SettingView: View {
    //
    @StateObject var container: MVIContainer<SettingIntent, SettingModelState>
    private var intent: SettingIntent { container.intent }
    private var state: SettingModelState { container.model }
    
    //
    public init() {
        let model = SettingModelImp()
        let intent = SettingIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as SettingIntent,
            model: model as SettingModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        NavigationStack {
            // 스크롤 뷰
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(SettingItem.allCases, id: \.self) { item in
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
        .sheet(
            isPresented: Binding(get: { state.showPasswordSheetView },
                                 set: { intent.setShowPasswordSheet($0) }),
            onDismiss: {
                intent.dismissPasswordSheet()
            },
            content: {
                PasswordSheetView { [weak intent] in
                    intent?.completePasswordSetting()
                }
            }
        )
        // 알람 설정
        .sheet(
            isPresented: Binding(get: { state.showAlarmSheetView },
                                 set: { intent.setShowAlarmSheet($0) }),
            onDismiss: {
                intent.dismissAlarmSheet()
            },
            content: {
                AlarmSheetView(alarmTime: state.alarmTime) { [weak intent] alarmTime in
                    intent?.setAlarmTime(alarmTime)
                } finishSetAlarmCompletion: { [weak intent] in
                    intent?.completeAlarmSetting()
                }
            }
        )
        // 다크 모드 / 라이트 모드
        .sheet(
            isPresented: Binding(get: { state.showSchemePickerView },
                                 set: { intent.setShowSchemePicker($0) }),
            onDismiss: {
                intent.dismissSchemePicker()
            },
            content: {
                SchemePickerView(previews: state.schemePreviews)
            }
        )
        .onAppear {
            intent.viewOnAppear()
        }
        .animation(.easeInOut(duration: 0.25), value: intent.appScheme)
        //
        .tint(DesignSystemAsset.black)
    }
}

// MARK: -
extension SettingView {
    @ViewBuilder
    private func settingItemIcon(_ item: SettingItem) -> some View {
        switch item.type {
        case .navigate:
            Button {
                // TODO: -
                switch item {
                case .displayMode:
                    intent.openSchemePicker()
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
                if item == .notice,
                   state.toggleStates[.notice] == true {
                    Text(state.formattedAlarmTime)
                        .textStyle(Paragraph())
                }
                //
                Toggle("", isOn: Binding(
                    get: { state.toggleStates[item] ?? false },
                    set: { intent.setToggle(value: $0, item: item) }
                ))
                .labelsHidden()
                .tint(DesignSystemAsset.bittersweet)
            }
        case .text:
            Text(state.formattedAppVersion)
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
}
