//
//  JournalContentControl.swift
//  MainFeature
//
//  Created by phang on 9/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import FeatureDependency

// MARK: -
struct JournalContentControl: Identifiable, Hashable {
    let id: UUID = .init()
    var symbol: String = ""
    var type: JournalType
    var frame: CGRect = .zero
    var controlSize: JournalContentControlSize = .card // default (추후 업데이트)
}

var sampleControls: [JournalContentControl] = [
    .init(symbol: "timer.circle.fill", type: .withinThreeMinutes),
    .init(symbol: "die.face.1.fill", type: .voiceRecording),
    .init(symbol: "sparkles", type: .resolution),
    .init(symbol: "pencil.line", type: .freely)
]