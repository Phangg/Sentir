//
//  JournalIntent.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

protocol JournalIntent: AnyObject, JournalListIntent, JournalCalenderIntent {
    //
    func openFilterSheet()
    func dismissFilterSheet()
    func toggleJournalViewMode(completion: @escaping () -> Void)
    func onChangedCurrentJournalView(state: JournalViewState, date: Date)
    func resetSelectedMonthAndDates()
    func setValue(_ journals: [String: [Journal]])
    func setValue(isLoading: Bool)
    func setValue(_ selectedMonthAndDates: Date)
    func setValue(showFilterSheet: Bool)
    func setValue(_ filterState: JournalFilterState)
    func updateListTypeToSearch(result: [String: [Journal]])
    func finishedSearchView()
}
