//
//  JournalModelImp+List.swift
//  JournalFeature
//
//  Created by phang on 12/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

// MARK: - JournalListModelAction
extension JournalModelImp {
    func deleteJournalItem(at indexSet: IndexSet, for dateInfo: String) {
        //
        if var journals = self.journals[dateInfo] {
            journals.remove(atOffsets: indexSet)
            //
            if journals.isEmpty {
                self.journals.removeValue(forKey: dateInfo)
            } else {
                self.journals[dateInfo] = journals
            }
        }
    }
}
