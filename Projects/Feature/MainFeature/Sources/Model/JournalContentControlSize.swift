//
//  JournalContentControlSize.swift
//  MainFeature
//
//  Created by phang on 11/7/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common

// MARK: -
enum JournalContentControlSize {
    case fourByFour
    case fourBytwo
    case twoByTwo
    case twoByFour
    case card
    
    var size: CGSize {
        switch self {
        case .fourByFour:
            ViewValues.fourByFour
        case .fourBytwo:
            ViewValues.fourBytwo
        case .twoByTwo:
            ViewValues.twoByTwo
        case .twoByFour:
            ViewValues.twoByFour
        case .card:
            ViewValues.cardSize
        }
    }
}
