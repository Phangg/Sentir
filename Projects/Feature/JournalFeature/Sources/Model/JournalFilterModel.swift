//
//  JournalFilterModel.swift
//  JournalFeature
//
//  Created by phang on 12/10/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

import Common

// MARK: - State
protocol JournalFilterModelState: AnyObject {
    var filterState: JournalFilterState { get }
    var showFilterSheet: Bool { get }
}

// MARK: - Action
protocol JournalFilterModelAction: AnyObject {
    func updateFilterState(_ state: JournalFilterState) -> AnyPublisher<Void, Never>
    func toggleShowFilterSheet()
}
