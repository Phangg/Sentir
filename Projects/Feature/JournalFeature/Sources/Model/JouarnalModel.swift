//
//  JouarnalModel.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

// MARK: - State
protocol JouarnalModelState: AnyObject {
    var currentJournalViewState: JournalViewState { get }
    var filterState: JournalFilterState { get }
    var showFilterSheet: Bool { get }
    var selectedMonthAndDates: Date { get }
}

// MARK: - Action
protocol JouarnalModelAction: AnyObject {
    func updateFilterState(_ state: JournalFilterState)
    func updateShowFilterSheet(_ value: Bool)
    func updateSelectedMonthAndDates(_ date: Date)
    func toggleJournalViewMode()
}
