//
//  Journal.swift
//  JournalFeature
//
//  Created by phang on 9/5/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Common
import Foundation
import FeatureDependency

// MARK: - 저장되는 데이터 모델
public struct JournalData {
    public var journalData: [String: [Journal]] = [:]
    
    public init() { }
    
    // MARK: - 임시 테스트 데이터
    public static let sample: [String: [Journal]] = [
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
}

// MARK: - 일기 데이터 모델
public struct Journal: Hashable, Identifiable {
    public let id: UUID = .init()
    public var dateInfo: String
    public var timeInfo: String
    public var content: String
    public var type: JournalType
    
    public init(
        content: String,
        type: JournalType
    ) {
        self.dateInfo = DateFormat.monthAndDayInfoString(Date())
        self.timeInfo = DateFormat.dateToTimeInfoString(Date())
        self.content = content
        self.type = type
    }
}
