//
//  JournalStore.swift
//  Domain
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

public protocol JournalStore {
    //
    func fetchJournals() -> [JournalGroup]
    func addJournal(_ journal: Journal)
    func updateJournal(_ journal: Journal)
    func deleteJournal(_ journal: Journal)
}
