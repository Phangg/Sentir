//
//  JournalIntentImp.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine
import Foundation

final class JournalIntentImp {
    //
    private weak var model: JouarnalModelAction?
    // Combine
    var cancellables = Set<AnyCancellable>()

    //
    init(
        model: JouarnalModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension JournalIntentImp: JournalIntent {
    func openFilterSheet() {
        model?.updateShowFilterSheet(true)
    }
    
    func dismissFilterSheet() {
        model?.updateShowFilterSheet(false)
    }
    
    func toggleJournalViewMode(completion: @escaping () -> Void) {
        model?.toggleJournalViewMode()
        Just(())
            .delay(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
    
    func resetSelectedMonthAndDates() {
        model?.updateSelectedMonthAndDates(Date())
    }
    
    func setValue(_ selectedMonthAndDates: Date) {
        model?.updateSelectedMonthAndDates(selectedMonthAndDates)
    }
    
    func setValue(_ showFilterSheet: Bool) {
        model?.updateShowFilterSheet(showFilterSheet)
    }
    
    func setValue(_ filterState: JournalFilterState) {
        model?.updateFilterState(filterState)
    }
}
