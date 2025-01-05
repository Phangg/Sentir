//
//  SearchModel.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol SearchModelState: AnyObject, SearchBarModelState {
    var isSearchFocused: Bool { get }
    var searchText: String { get }
    var searchState: JournalSearchState { get }
}

// MARK: - Action
protocol SearchModelAction: AnyObject, SearchBarModelAction {
    func updateSearchFocused(_ value: Bool)
}
