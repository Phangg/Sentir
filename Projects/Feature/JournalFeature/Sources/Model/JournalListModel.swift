//
//  JournalListModel.swift
//  JournalFeature
//
//  Created by phang on 12/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

// MARK: - State
protocol JournalListModelState: AnyObject {
    var journals: [String: [Journal]] { get }
    var isLoading: Bool { get }
    var filterState: JournalFilterState { get }
    var listType: JournalListViewType { get }
}

// MARK: - Action
protocol JournalListModelAction: AnyObject {
    func deleteJournalItem(at indexSet: IndexSet, for dateInfo: String)
}
