//
//  JournalFilterIntent.swift
//  JournalFeature
//
//  Created by phang on 12/10/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

protocol JournalFilterIntent: AnyObject {
    func tapFilterButton(_ state: JournalFilterState)
}
