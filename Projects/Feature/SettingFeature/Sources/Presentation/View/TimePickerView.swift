//
//  TimePickerView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

enum TimeOfDay: String, CaseIterable {
    case am = "오전"
    case pm = "오후"
}

struct TimePickerView: View {
    @State private var timeOfDay: TimeOfDay = .pm
    @State private var hours: Int = 6
    @State private var minutes: Int = 0
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
                Picker("오전 / 오후", selection: $timeOfDay) {
                    ForEach(TimeOfDay.allCases, id: \.self) { timeOfDay in
                        Text(timeOfDay.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                //
                Picker("시", selection: $hours) {
                    ForEach(1..<13) { hour in
                        Text(String(format: "%02d", hour))
                            .tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                //
                Picker("분", selection: $minutes) {
                    ForEach(0..<60) { minute in
                        Text(String(format: "%02d", minute))
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
