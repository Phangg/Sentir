//
//  JournalUseCase.swift
//  Domain
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

import Common

public protocol JournalUseCase {
    //
    func fetchJournals() -> AnyPublisher<[String: [Journal]], Error>
    func addJournal(_ journal: Journal)
    func updateJournal(_ journal: Journal)
    func deleteJournal(_ journal: Journal)
    //
    func searchJournals(text: String) -> AnyPublisher<[String: [Journal]], Error>
}
