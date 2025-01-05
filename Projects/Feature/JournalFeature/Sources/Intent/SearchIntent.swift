//
//  SearchIntent.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

protocol SearchIntent: AnyObject, SearchBarIntent {
    //
    var tabBarState: TabBarStateManageable { get }
    var handleSearchCompletion: ([String: [Journal]]) -> Void { get }
    //
    @MainActor func viewOnAppear()
    @MainActor func tapBackButton()
    //
    func activateSearchFocus()
    func deactivateSearchFocus()
}
