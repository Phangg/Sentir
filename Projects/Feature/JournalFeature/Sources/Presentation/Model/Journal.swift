//
//  Journal.swift
//  JournalFeature
//
//  Created by phang on 9/5/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Common
import Foundation

// MARK: - 저장되는 데이터 모델
public struct JournalData {
    public var journalData: [String: [Journal]] = [:]
    
    public init() { }
    
    // MARK: - 임시 테스트 데이터
    public static let sample: [String: [Journal]] = [
        DateFormat.dateToDateInfoString(Date(timeIntervalSinceNow: -864000)): [
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        ],
        DateFormat.dateToDateInfoString(Date(timeIntervalSinceNow: -86400)): [
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
        ],
        DateFormat.dateToDateInfoString(Date()): [
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            .init(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.......")
        ]
    ]
}

// MARK: - 일기 데이터 모델
public struct Journal: Identifiable {
    public let id: UUID = .init()
    public var timeInfo: String
    public var content: String
    
    public init(
        content: String
    ) {
        self.timeInfo = DateFormat.dateToTimeInfoString(Date())
        self.content = content
    }
}
