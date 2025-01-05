//
//  JournalStoreImp.swift
//  Data
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftData

import Common
import Domain
import Foundation

public final class JournalStoreImp: JournalStore {
    //
    private let modelContext: ModelContext
    
    //
    public init() {
        let modelContainer: ModelContainer = {
            let schema = Schema([Journal.self, JournalGroup.self])
            let modelConfig = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                cloudKitDatabase: .none
            )
            do {
                return try ModelContainer(for: schema, configurations: [modelConfig])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        self.modelContext = ModelContext(modelContainer)
    }

    //
    public func fetchJournals() -> [JournalGroup] {
        do {
            //
            let descriptor = FetchDescriptor<JournalGroup>()
            let journalGroups = try modelContext.fetch(descriptor)
            return journalGroups
        } catch {
            // TODO: - 에러 처리
            print("Error fetchJournals: \(error)")
            return []
        }
    }
    
    public func addJournal(_ journal: Journal) {
        let dateInfo = journal.dateInfo
        //
        do {
            var journalGroup: JournalGroup
            let descriptor = FetchDescriptor<JournalGroup>(
                predicate: #Predicate<JournalGroup> { $0.dateInfo == dateInfo }
            )
            //
            let existingGroups = try modelContext.fetch(descriptor)
            //
            if let existingGroup = existingGroups.first {
                journalGroup = existingGroup
                journalGroup.journals.append(journal)
            } else {
                journalGroup = JournalGroup(dateInfo: dateInfo, journals: [journal])
                modelContext.insert(journalGroup)
            }
            try modelContext.save()
        } catch {
            // TODO: - 에러 처리
            print("Error addJournal: \(error)")
        }
    }
    
    public func updateJournal(_ journal: Journal) {
        //
    }
    
    public func deleteJournal(_ journal: Journal) {
        //
    }
}
