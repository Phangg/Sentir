//
//  JournalIntent.swift
//  JournalFeature
//
//  Created by phang on 11/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

protocol JournalIntent: AnyObject {
    //
    func openFilterSheet()
    func dismissFilterSheet()
    func toggleJournalViewMode(completion: @escaping () -> Void)
    func resetSelectedMonthAndDates()
    func setValue(_ selectedMonthAndDates: Date)
    func setValue(_ showFilterSheet: Bool)
    func setValue(_ filterState: JournalFilterState)
}
