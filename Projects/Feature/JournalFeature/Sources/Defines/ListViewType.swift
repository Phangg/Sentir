//
//  ListViewType.swift
//  JournalFeature
//
//  Created by phang on 9/17/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Common

public enum JournalListViewType: Equatable, Hashable {
    case all
    case day(dateInfo: String)
    case search(searchedJournals: [String: [Journal]])
}
