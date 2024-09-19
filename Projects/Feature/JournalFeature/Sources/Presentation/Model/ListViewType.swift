//
//  ListViewType.swift
//  JournalFeature
//
//  Created by phang on 9/17/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

public enum ListViewType {
    case all(sortBy: JournalFilterState)
    case day(dateInfo: String)
    case search(searchText: String)
}
