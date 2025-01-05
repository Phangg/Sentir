//
//  JournalFilterIntentImp.swift
//  JournalFeature
//
//  Created by phang on 12/10/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

import Common

final class JournalFilterIntentImp {
    //
    private weak var model: JournalFilterModelAction?
    // Combine
    var cancellables = Set<AnyCancellable>()
    
    //
    init(
        model: JournalFilterModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension JournalFilterIntentImp: JournalFilterIntent {
    func tapFilterButton(_ state: JournalFilterState) {
        model?.updateFilterState(state)
            .sink { [weak self] _ in
                self?.model?.toggleShowFilterSheet()
            }
            .store(in: &cancellables)
    }
}
