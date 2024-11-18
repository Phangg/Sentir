//
//  JournalContentControl.swift
//  MainFeature
//
//  Created by phang on 9/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import JournalHandlerFeature

// MARK: -
struct JournalContentControl: Identifiable, Hashable {
    let id: UUID = .init()
    var type: JournalType
    var frame: CGRect = .zero
    var controlSize: JournalContentControlSize = .card // default (추후 업데이트)
    
    static let controls: [JournalContentControl] = [
        .init(type: .withinThreeMinutes),
        .init(type: .voiceRecording),
        .init(type: .resolution),
        .init(type: .freely)
    ]
}
