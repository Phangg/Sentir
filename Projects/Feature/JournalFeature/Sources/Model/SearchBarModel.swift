//
//  SearchBarModel.swift
//  JournalFeature
//
//  Created by phang on 12/17/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol SearchBarModelState: AnyObject {
    var isSearchFocused: Bool { get }
    var searchText: String { get }
    var searchState: JournalSearchState { get }
}

// MARK: - Action
protocol SearchBarModelAction: AnyObject {
    func updateSearchText(_ text: String)
    func updateSearchState(_ state: JournalSearchState)
    func updateSearchFocused(_ value: Bool)
}
