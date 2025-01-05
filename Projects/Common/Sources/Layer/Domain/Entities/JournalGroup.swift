//
//  JournalGroup.swift
//  Common
//
//  Created by phang on 12/9/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import SwiftData

@Model
public class JournalGroup {
    public var dateInfo: String
    public var journals: [Journal]
    
    public init(
        dateInfo: String,
        journals: [Journal]
    ) {
        self.dateInfo = dateInfo
        self.journals = journals
    }
}

    
// MARK: - 임시 테스트 데이터
public let journalsDataSample: [String: [Journal]] = [
    DateFormat.dateToDateInfoString(Date(timeIntervalSinceNow: -864000)): [
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              type: .freely),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              type: .resolution),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              type: .withinThreeMinutes)
    ],
    DateFormat.dateToDateInfoString(Date(timeIntervalSinceNow: -172800)): [
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              type: .voiceRecording),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              type: .withinThreeMinutes),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              type: .resolution),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              type: .freely),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              type: .resolution)
    ],
    DateFormat.dateToDateInfoString(Date(timeIntervalSinceNow: -86400)): [
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              type: .freely),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              type: .voiceRecording)
    ],
    DateFormat.dateToDateInfoString(Date()): [
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry.......",
              type: .withinThreeMinutes),
        .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.......",
              type: .freely)
    ]
]
