//
//  Journal.swift
//  Common
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import SwiftData

@Model
public class Journal: Hashable, Identifiable {
    public var id: UUID
    public var dateInfo: String
    public var timeInfo: String
    public var content: String
    public var type: JournalType
    
    public init(
        id: UUID = UUID(),
        content: String,
        type: JournalType
    ) {
        self.id = id
        self.dateInfo = DateFormat.dateToDateInfoString(Date())
//        self.dateInfo = DateFormat.monthAndDayInfoString(Date())
        self.timeInfo = DateFormat.dateToTimeInfoString(Date())
        self.content = content
        self.type = type
    }
}
