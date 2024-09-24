//
//  TimePickerView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

public enum TimeOfDay: String, CaseIterable {
    case am = "오전"
    case pm = "오후"
}

struct TimePickerView: View {
    @Binding var alarmTime: AlarmTime
    @Binding var showAlarmSheetView: Bool
    let onComplete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //
            HStack(alignment: .center) {
                Text("알람 설정")
                    .textStyle(SmallTitle(weight: .medium))
                Spacer(minLength: 0)
                Button {
                    showAlarmSheetView = false
                    onComplete()
                    // TODO: -
                } label: {
                    Text("완료")
                        .textStyle(Paragraph(weight: .medium))
                }
            }
            //
            Text("'나의 다짐' 중 하나를 \n매일 원하는 시간에 받아 볼 수 있어요.")
                .textStyle(Paragraph(color: DesignSystemAsset.darkGray))
                .lineLimit(2)
            //
            Spacer(minLength: 0)
            //
            HStack {
                //
                Picker("오전 / 오후", selection: $alarmTime.timeOfDay) {
                    ForEach(TimeOfDay.allCases, id: \.self) { timeOfDay in
                        Text(timeOfDay.rawValue)
                            .textStyle(Paragraph())
                    }
                }
                .pickerStyle(.wheel)
                //
                Picker("시", selection: $alarmTime.hours) {
                    ForEach(1..<13) { hour in
                        Text(String(format: "%02d", hour))
                            .textStyle(Paragraph())
                            .tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                //
                Picker("분", selection: $alarmTime.minutes) {
                    ForEach(0..<60) { minute in
                        Text(String(format: "%02d", minute))
                            .textStyle(Paragraph())
                    }
                }
                .pickerStyle(.wheel)
            }
            .frame(height: 140)
        }
        .padding(20)
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
        .padding(.horizontal, 20)
        .presentationDetents([.height(280)])
        .presentationBackground(.clear)
    }
}
