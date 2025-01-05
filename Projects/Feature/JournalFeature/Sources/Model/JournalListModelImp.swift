//
//  JournalListModelImp.swift
//  JournalFeature
//
//  Created by phang on 12/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

final class JournalListModelImp: ObservableObject, JournalListModelState {
    @Published private(set) var journals: [String : [Journal]]
    @Published private(set) var isLoading: Bool
    @Published private(set) var filterState: JournalFilterState
    @Published private(set) var listType: JournalListViewType
    
    init(
        journals: [String : [Journal]],
        isLoading: Bool,
        filterState: JournalFilterState,
        listType: JournalListViewType
    ) {
        self.journals = journals
        self.isLoading = isLoading
        self.filterState = filterState
        self.listType = listType
    }
}

extension SearchModelImp: JournalListModelAction {
    func deleteJournalItem(at indexSet: IndexSet, for dateInfo: String) {
        //
    }
}
