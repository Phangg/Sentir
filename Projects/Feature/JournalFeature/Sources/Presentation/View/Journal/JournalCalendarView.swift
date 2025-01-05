//
//  JournalCalendarView.swift
//  JournalFeature
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

struct JournalCalendarView: View {
    @EnvironmentObject var container: MVIContainer<JournalIntent, JournalModelState>
    private var intent: JournalCalenderIntent { container.intent }
    private var state: JournalCalenderModelState { container.model }
    
    var body: some View {
        VStack(alignment: .leading) {
            //
            CalendarHeaderView
                .onChange(of: state.currentMonth) { _, _ in
                    intent.onChangeMonth()
                }
            //
            CalendarGridView
                .id(state.refreshID)
        }
        .padding([.horizontal, .bottom], ViewValues.defaultPadding)
        .padding(.top, ViewValues.halfPadding)
    }
}

extension JournalCalendarView {
    //
    @ViewBuilder
    fileprivate var CalendarHeaderView: some View {
        //
        HStack(alignment: .center, spacing: 20) {
            //
            Button {
                intent.changeMonth(by: .previous)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
            }
            .disabled(!state.canMoveToPreviousMonth)
            //
            Text(state.currentMonth, formatter: DateFormat.calendarHeaderDateFormatter)
                .textStyle(MediumTitle(weight: .semibold))
                .frame(width: 100)
            //
            Button {
                intent.changeMonth(by: .next)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
            }
            .disabled(!state.canMoveToNextMonth)
        }
        .padding(.bottom, ViewValues.halfPadding)
        //
        HStack(alignment: .center, spacing: 10) {
            ForEach(state.weekDays.indices, id: \.self) { idx in
                Text(state.weekDays[idx])
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
    fileprivate var CalendarGridView: some View {
        let daysInMonth: Int = state.numberOfDays(in: state.currentMonth)
        let firstWeekday: Int = state.firstWeekdayOfMonth(in: state.currentMonth) - 1
        let lastDayOfMonthBefore: Int = state.numberOfDays(in: state.previousMonth())
        let numberOfRows: Int = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth: Int = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday..<daysInMonth + visibleDaysOfNextMonth, id: \.self) { idx in
                Group {
                    if idx > -1, idx < daysInMonth {
                        //
                        let date = state.getDate(for: idx)
                        let day = Calendar.current.component(.day, from: date)
                        let isSelected = DateFormat.calendarDayString(state.selectedMonthAndDates) == DateFormat.calendarDayString(date)
                        let isToday = DateFormat.calendarDayString(date) == DateFormat.calendarDayString(Date())
                        let hasJournalFlag = state.getJournalFlag(for: date)
                        
                        CalendarCellView(
                            day: day,
                            isSelected: isSelected,
                            isToday: isToday,
                            hasJournalFlag: hasJournalFlag
                        )
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: idx + lastDayOfMonthBefore,
                        to: state.previousMonth()
                    ) {
                        //
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        //
                        CalendarCellView(
                            day: day,
                            isCurrentMonthDay: false,
                            hasJournalFlag: JournalFlag.nothing
                        )
                    }
                }
                .onTapGesture {
                    intent.tapCalenderCell(idx, daysInMonth: daysInMonth)
                }
            }
        }
    }
}
