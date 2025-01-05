//
//  SearchModelImp.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import SwiftUI

final class SearchModelImp: ObservableObject, SearchModelState {
    @Published private(set) var isSearchFocused: Bool
    @Published private(set) var searchText: String
    @Published private(set) var searchState: JournalSearchState
    
    init(
        isSearchFocused: Bool = false,
        searchText: String = "",
        searchState: JournalSearchState = .none
    ) {
        self.isSearchFocused = isSearchFocused
        self.searchText = searchText
        self.searchState = searchState
    }
    
}

extension SearchModelImp: SearchModelAction {
    func updateSearchFocused(_ value: Bool) {
        isSearchFocused = value
    }
    
    func updateSearchText(_ text: String) {
        searchText = text
    }
    
    func updateSearchState(_ state: JournalSearchState) {
        searchState = state
    }
}
