//
//  CalendarView.swift
//  JournalFeature
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct CalendarView: View {
    @State private var month: Date = Date()
    @State private var selectedMonthAndDates: Date? = nil
    @State private var refreshId = UUID()
    
    public init() { }
    
    public var body: some View {
        VStack(alignment: .leading) {
            //
            CalendarHeaderView()
            //
            CalendarGridView()
                .id(refreshId)
        }
        .padding([.horizontal, .bottom], 20)
        .padding(.top, 10)
    }
    
    // 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    // 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    // 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    // 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    // 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
        self.refreshId = UUID()
    }
    
    // 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -60, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: -1) < targetDate {
            return false
        }
        return true
    }
    
    // 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 60, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        return true
    }
    
    // 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
    
    //
    @ViewBuilder
    fileprivate func CalendarHeaderView() -> some View {
        //
        HStack(alignment: .center, spacing: 20) {
            //
            Button {
                changeMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
            }
            .disabled(!canMoveToPreviousMonth())
            //
            Text(month, formatter: DateFormat.calendarHeaderDateFormatter)
                .textStyle(MediumTitle(weight: .semibold))
            //
            Button {
                changeMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
            }
            .disabled(!canMoveToNextMonth())
        }
        .padding(.bottom, 10)
        //
        HStack(alignment: .center, spacing: 10) {
            let week = ["일", "월", "화", "수", "목", "금", "토"]
            ForEach(week.indices, id: \.self) { idx in
                Text(week[idx])
                    .textStyle(
                        SmallTitle(
                            weight: .medium,
                            color: (idx == 0 || idx == 6) ? DesignSystemAsset.lightGray : DesignSystemAsset.darkGray
                        )
                    )
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    //
    @ViewBuilder
    fileprivate func CalendarGridView() -> some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore: Int = numberOfDays(in: previousMonth())
        let numberOfRows: Int = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth: Int = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday..<daysInMonth + visibleDaysOfNextMonth, id: \.self) { idx in
                Group {
                    if idx > -1, idx < daysInMonth {
                        //
                        let date = getDate(for: idx)
                        let day = Calendar.current.component(.day, from: date)
                        let isSelected = selectedMonthAndDates == date
                        let isToday = DateFormat.calendarDayString(date) == DateFormat.calendarDayString(Date())
                        
                        CalendarCellView(
                            day: day,
                            isSelected: isSelected,
                            isToday: isToday,
                            hasJournalFlag: JournalFlag.low
                        )
                    } else if let prevMonthDate = Calendar.current.date(byAdding: .day, value: idx + lastDayOfMonthBefore, to: previousMonth()) {
                        //
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                    
                        CalendarCellView(
                            day: day,
                            isCurrentMonthDay: false,
                            hasJournalFlag: JournalFlag.medium
                        )
                    }
                }
                .onTapGesture {
                    if 0 <= idx, idx < daysInMonth {
                        let date = getDate(for: idx)
                        selectedMonthAndDates = date
                    }
                }
            }
        }
    }
}
