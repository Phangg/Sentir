//
//  JournalModelImp+Calender.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import Common

// MARK: - JournalCalenderModelState
extension JournalModelImp {
    // 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: currentMonth),
                month: calendar.component(.month, from: currentMonth),
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
        Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    // 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    // 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        return previousMonth
    }
    
    func getJournalFlag(for date: Date) -> JournalFlag {
        let dateInfo = DateFormat.dateToDateInfoString(date)
        
        guard let journals = journals[dateInfo] else {
            return .nothing
        }
        
        if journals.count == JournalFlag.low.rawValue {
            return .low
        } else if journals.count <= JournalFlag.medium.rawValue {
            return .medium
        } else {
            return .high
        }
    }
    
    // 변경하려는 월 반환
    private func adjustedMonth(by direction: MonthMoveDirectionInCalendar) -> Date {
        if let newMonth = Calendar.current.date(
            byAdding: .month,
            value: direction.rawValue,
            to: currentMonth
        ) {
            return newMonth
        }
        return currentMonth
    }
    
    //
    private func updateRefreshID() {
        refreshID = UUID()
    }
}

// MARK: - JournalCalenderModelAction
extension JournalModelImp {
    func changeMonth(by direction: MonthMoveDirectionInCalendar) {
        currentMonth = adjustedMonth(by: direction)
        updateRefreshID()
    }
    
    func updateCanMoveMonth(to direction: MonthMoveDirectionInCalendar) {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(
            byAdding: .month,
            value: direction == .next ? maxMonthRange : -maxMonthRange,
            to: currentDate
        ) ?? currentDate
        //
        let canMove = direction == .next ?
        (adjustedMonth(by: direction) <= targetDate) : (adjustedMonth(by: direction) >= targetDate)
        switch direction {
        case .next:
            canMoveToNextMonth = canMove
        case .previous:
            canMoveToPreviousMonth = canMove
        }
    }
    
    func tapCalenderCell(_ idx: Int, daysInMonth: Int) {
        if 0 <= idx, idx < daysInMonth {
            let date = getDate(for: idx)
            selectedMonthAndDates = date
        }
    }
}
