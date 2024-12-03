//
//  JouarnalModelImp.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

final class JouarnalModelImp: ObservableObject, JouarnalModelState {
    @Published private(set) var currentJournalViewState: JournalViewState
    @Published private(set) var filterState: JournalFilterState
    @Published private(set) var showFilterSheet: Bool
    @Published private(set) var selectedMonthAndDates: Date
    
    init(
        currentJournalViewState: JournalViewState = .calendar,
        filterState: JournalFilterState = .newest,
        showFilterSheet: Bool = false,
        selectedMonthAndDates: Date = Date()
    ) {
        self.currentJournalViewState = currentJournalViewState
        self.filterState = filterState
        self.showFilterSheet = showFilterSheet
        self.selectedMonthAndDates = selectedMonthAndDates
    }
}

extension JouarnalModelImp: JouarnalModelAction {
    func updateFilterState(_ state: JournalFilterState) {
        filterState = state
    }
    
    func updateShowFilterSheet(_ value: Bool) {
        showFilterSheet = value
    }
    
    func updateSelectedMonthAndDates(_ date: Date) {
        selectedMonthAndDates = date
    }
    
    func toggleJournalViewMode() {
        let state = currentJournalViewState
        currentJournalViewState = state == .calendar ? .list : .calendar
    }
}
