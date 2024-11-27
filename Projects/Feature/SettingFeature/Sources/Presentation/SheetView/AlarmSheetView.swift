//
//  AlarmSheetView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

struct AlarmSheetView: View {
    @StateObject var container: MVIContainer<AlarmIntent, AlarmModelState>
    private var intent: AlarmIntent { container.intent }
    private var state: AlarmModelState { container.model }
    
    //
    init(
        alarmTime: AlarmTime,
        updateAlarmTimeCompletion: @escaping (AlarmTime) -> Void,
        finishSetAlarmCompletion: @escaping () -> Void
    ) {
        let model = AlarmModelImp(alarmTime: alarmTime)
        let intent = AlarmIntentImp(
            model: model,
            setAlarmTimeCompletion: updateAlarmTimeCompletion,
            finishSetAlarmCompletion: finishSetAlarmCompletion
        )
        let container = MVIContainer(
            intent: intent as AlarmIntent,
            model: model as AlarmModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 상단 헤더 (타이틀 & 완료 버튼)
            alarmSheetHeader
            // 설명 텍스트
            Text("'나의 다짐' 중 하나를 \n매일 원하는 시간에 받아 볼 수 있어요.")
                .textStyle(Paragraph(color: DesignSystemAsset.darkGray))
                .lineLimit(2)
            //
            Spacer(minLength: 0)
            // 시간 선택
            alarmTimePicker(alarmTime: state.alarmTime)
        }
        .padding(ViewValues.defaultPadding)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                Rectangle()
                    .fill(.primary.opacity(0.05))
            }
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal, ViewValues.defaultPadding)
        .presentationDetents([.height(280)])
        .presentationBackground(.clear)
    }
}

// MARK: -
extension AlarmSheetView {
    @ViewBuilder
    private var alarmSheetHeader: some View {
        HStack(alignment: .center) {
            Text("알람 설정")
                .textStyle(SmallTitle(weight: .medium))
            Spacer(minLength: 0)
            Button {
                //
                intent.completeAlarmSetting()
            } label: {
                Text("완료")
                    .textStyle(Paragraph(weight: .medium))
            }
        }
    }

    @ViewBuilder
    private func alarmTimePicker(alarmTime: AlarmTime) -> some View {
        HStack {
            //
            Picker("오전 / 오후",
                   selection: Binding(get: { alarmTime.timeOfDay },
                                      set: { intent.updateAlarmTime(
                                        AlarmTime(timeOfDay: $0,
                                                  hours: alarmTime.hours,
                                                  minutes: alarmTime.minutes)) })
            ) {
                ForEach(TimeOfDay.allCases, id: \.self) { timeOfDay in
                    Text(timeOfDay.rawValue)
                        .textStyle(Paragraph())
                }
            }
            .pickerStyle(.wheel)
            //
            Picker("시",
                   selection: Binding(get: { alarmTime.hours },
                                      set: { intent.updateAlarmTime(
                                        AlarmTime(timeOfDay: alarmTime.timeOfDay,
                                                  hours: $0,
                                                  minutes: alarmTime.minutes)) })
            ) {
                ForEach(1..<13) { hour in
                    Text(String(format: "%02d", hour))
                        .textStyle(Paragraph())
                        .tag(hour)
                }
            }
            .pickerStyle(.wheel)
            //
            Picker("분",
                   selection: Binding(get: { alarmTime.minutes },
                                      set: { intent.updateAlarmTime(
                                        AlarmTime(timeOfDay: alarmTime.timeOfDay,
                                                  hours: alarmTime.hours,
                                                  minutes: $0)) })
            ) {
                ForEach(0..<60) { minute in
                    Text(String(format: "%02d", minute))
                        .textStyle(Paragraph())
                }
            }
            .pickerStyle(.wheel)
        }
        .frame(height: 140)
    }
}
