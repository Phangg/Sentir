//
//  JournalCalenderModel.swift
//  JournalFeature
//
//  Created by phang on 12/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

// MARK: - State
protocol JournalCalenderModelState: AnyObject {
    var currentMonth: Date { get }
    var refreshID: UUID { get }
    var selectedMonthAndDates: Date { get }
    var canMoveToPreviousMonth: Bool { get }
    var canMoveToNextMonth: Bool { get }
    var weekDays: [String] { get }
    // CalendarGridView - 데이터만 반환
    func getDate(for index: Int) -> Date
    func numberOfDays(in date: Date) -> Int
    func firstWeekdayOfMonth(in date: Date) -> Int
    func previousMonth() -> Date
    func getJournalFlag(for date: Date) -> JournalFlag
}

// MARK: - Action
protocol JournalCalenderModelAction: AnyObject {
    func changeMonth(by direction: MonthMoveDirectionInCalendar)
    func updateCanMoveMonth(to direction: MonthMoveDirectionInCalendar)
    func tapCalenderCell(_ idx: Int, daysInMonth: Int)
}
