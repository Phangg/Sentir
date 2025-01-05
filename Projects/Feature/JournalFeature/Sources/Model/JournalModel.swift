//
//  JournalModel.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

// MARK: - State
protocol JournalModelState: AnyObject,
                            JournalListModelState,
                            JournalCalenderModelState
{
    var journals: [String: [Journal]] { get }
    var isLoading: Bool { get }
    var currentJournalViewState: JournalViewState { get }
    var filterState: JournalFilterState { get }
    var showFilterSheet: Bool { get }
    var selectedMonthAndDates: Date { get }
}

// MARK: - Action
protocol JournalModelAction: AnyObject,
                             JournalListModelAction,
                             JournalCalenderModelAction
{
    func updateJournals(_ journals: [String: [Journal]])
    func updateLoadingState(_ isLoading: Bool)
    func updateFilterState(_ state: JournalFilterState)
    func updateShowFilterSheet(_ value: Bool)
    func updateSelectedMonthAndDates(_ date: Date)
    func updateListType(_ newType: JournalListViewType)
    func toggleJournalViewMode()
}
