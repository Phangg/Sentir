//
//  CalendarCellView.swift
//  JournalFeature
//
//  Created by phang on 9/16/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct CalendarCellView: View {
    // 다크 모드 / 라이트 모드 설정
    @Environment(\.colorScheme) private var scheme
    var day: Int
    var isSelected: Bool = false
    var isToday: Bool = false
    var isCurrentMonthDay: Bool = true
    var hasJournalFlag: JournalFlag
    
    var textColor: Color {
        if isSelected {
            return DesignSystemAsset.white
        } else if isCurrentMonthDay {
            return DesignSystemAsset.black
        } else {
            return DesignSystemAsset.lightGray
        }
    }
    
    var backgroundColor: Color {
        if isSelected {
            return DesignSystemAsset.black
        } else if isToday {
            return DesignSystemAsset.gray008
        } else {
            return scheme == .dark ? Color.black : DesignSystemAsset.white
        }
    }
    
    var body: some View {
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            
            Spacer(minLength: 4)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(hasJournalFlag.flagColor)
                .frame(width: 6, height: 6)
        }
        .frame(height: 40)
    }
}
