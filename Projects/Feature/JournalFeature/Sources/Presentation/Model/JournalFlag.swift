//
//  JournalFlag.swift
//  JournalFeature
//
//  Created by phang on 9/16/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

public enum JournalFlag {
    case nothing
    case low
    case medium
    case high

    public var flagColor: Color {
        switch self {
        case .nothing:
            Color.clear
        case .low:
            DesignSystemAsset.lightGray
        case .medium:
            DesignSystemAsset.darkGray
        case .high:
            DesignSystemAsset.black
        }
    }
}
