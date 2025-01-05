//
//  JournalModelImp.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

final class JournalModelImp: ObservableObject, JournalModelState {
    @Published var journals: [String: [Journal]]
    @Published var isLoading: Bool
    @Published var currentJournalViewState: JournalViewState
    @Published var filterState: JournalFilterState
    @Published var showFilterSheet: Bool
    @Published var selectedMonthAndDates: Date
    // JournalListModelState
    @Published var listType: JournalListViewType
    // JournalCalenderModelState
    @Published var currentMonth: Date
    @Published var refreshID: UUID
    @Published var canMoveToPreviousMonth: Bool
    @Published var canMoveToNextMonth: Bool
    let maxMonthRange = 60
    let weekDays = ["일", "월", "화", "수", "목", "금", "토"]

    //
    init(
        journals: [String: [Journal]] = [:],
        isLoading: Bool = false,
        currentJournalViewState: JournalViewState = .calendar,
        filterState: JournalFilterState = .newest,
        showFilterSheet: Bool = false,
        selectedMonthAndDates: Date = Date(),
        currentMonth: Date = Date(),
        refreshID: UUID = UUID(),
        canMoveToPreviousMonth: Bool = true,
        canMoveToNextMonth: Bool = true
    ) {
        self.journals = journals
        self.isLoading = isLoading
        self.currentJournalViewState = currentJournalViewState
        self.filterState = filterState
        self.showFilterSheet = showFilterSheet
        self.selectedMonthAndDates = selectedMonthAndDates
        // JournalListModelState
        self.listType = .day(dateInfo: DateFormat.dateToDateInfoString(selectedMonthAndDates))
        // JournalListModelState
        self.currentMonth = currentMonth
        self.refreshID = refreshID
        self.canMoveToPreviousMonth = canMoveToPreviousMonth
        self.canMoveToNextMonth = canMoveToNextMonth
    }
}

// MARK: - JouarnalModelAction
extension JournalModelImp: JournalModelAction {
    func updateJournals(_ journals: [String : [Journal]]) {
        self.journals = journals
    }
    
    func updateLoadingState(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func updateFilterState(_ state: JournalFilterState) {
        filterState = state
    }
    
    func updateShowFilterSheet(_ value: Bool) {
        showFilterSheet = value
    }
    
    func updateSelectedMonthAndDates(_ date: Date) {
        selectedMonthAndDates = date
    }
    
    func updateListType(_ newType: JournalListViewType) {
        listType = newType
    }
    
    func toggleJournalViewMode() {
        let state = currentJournalViewState
        currentJournalViewState = state == .calendar ? .list : .calendar
    }
}
