//
//  JournalListIntent.swift
//  JournalFeature
//
//  Created by phang on 12/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

import Common

protocol JournalListIntent: AnyObject {
    //
    func deleteJournalItem(at indexSet: IndexSet, for dateInfo: String)
}
