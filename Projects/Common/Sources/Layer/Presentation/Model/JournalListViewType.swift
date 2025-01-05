//
//  JournalListViewType.swift
//  Common
//
//  Created by phang on 12/10/24.
//  Copyright © 2024 Phang. All rights reserved.
//

public enum JournalListViewType {
    case all(sortBy: JournalFilterState)
    case day(dateInfo: String)
    case search(searchText: String)
}
