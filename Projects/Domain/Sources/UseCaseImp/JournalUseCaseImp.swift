//
//  JournalUseCaseImp.swift
//  Domain
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

import Common

public final class JournalUseCaseImp: ObservableObject, JournalUseCase {
    //
    private let journalStore: JournalStore
    
    //
    public init(
        journalStore: JournalStore
    ) {
        self.journalStore = journalStore
    }
    
    //
    public func fetchJournals() -> AnyPublisher<[String: [Journal]], Error> {
        let journalGroups = journalStore.fetchJournals()
//        let journalsData = journalGroups
//            .reduce(into: [String: [Journal]]()) { result, group in
//                result[group.dateInfo] = group.journals
//            }
        let journalsData = journalsDataSample // TODO: - 테스트용 : 삭제 예정 코드
        return Just(journalsData)
            .setFailureType(to: Error.self) // TODO: - 에러 처리
            .eraseToAnyPublisher()
    }
    
    public func addJournal(_ journal: Journal) {
        journalStore.addJournal(journal)
    }
    
    public func updateJournal(_ journal: Journal) {
        journalStore.updateJournal(journal)
    }
    
    public func deleteJournal(_ journal: Journal) {
        journalStore.deleteJournal(journal)
    }
    
    public func searchJournals(text: String) -> AnyPublisher<[String: [Journal]], Error> {
        let journalGroups = journalStore.fetchJournals()
        let journalsData = journalsDataSample // TODO: - 테스트용 : 삭제 예정 코드
        let searchedJournals = journalsData
            .reduce(into: [String: [Journal]]()) { result, value in
                let (dateInfo, journals) = value
                let filteredJournals = journals.filter { journal in
                    journal.content.localizedCaseInsensitiveContains(text)
                }
                if !filteredJournals.isEmpty {
                    result[dateInfo] = filteredJournals
                }
            }
//        let filteredGroups = journalGroups.filter { group in
//            group.journals.contains { journal in
//                journal.content.localizedCaseInsensitiveContains(text)
//            }
//        }
//        let searchedJournals = Dictionary(grouping: filteredGroups,
//                                          by: { $0.dateInfo })
//            .mapValues { $0.flatMap { $0.journals } }
        return Just(searchedJournals)
            .setFailureType(to: Error.self) // TODO: - 에러 처리
            .eraseToAnyPublisher()
    }
}
