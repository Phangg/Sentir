//
//  JournalCalenderIntent.swift
//  JournalFeature
//
//  Created by phang on 12/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

protocol JournalCalenderIntent: AnyObject {
    func changeMonth(by direction: MonthMoveDirectionInCalendar)
    func onChangeMonth()
    func tapCalenderCell(_ idx: Int, daysInMonth: Int)
}
