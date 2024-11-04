//
//  MainContentControlBox.swift
//  MainFeature
//
//  Created by phang on 9/28/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common

// MARK: -
enum MainContentType: String, Hashable {
    case withinThreeMinutes = "3분의 순간"
    case voiceRecording = "말로 남기는 기록"
    case resolution = "오늘을 위한 다짐"
    case freely = "마음 가는 대로"
    
    var description: String {
        switch self {
        case .withinThreeMinutes:
            """
            3분의 타이머가 흘러가는 동안 순간의 생각을 기록해보세요.
            시간의 흐름 속에서 떠오르는 이야기를 남길 수 있어요.
            """
        case .voiceRecording:
            """
            목소리로 오늘의 감정을 남겨보세요.
            말로 기록하는 특별한 순간을 경험할 수 있습니다.
            """
        case .resolution:
            """
            이루고 싶은 다짐을 적어볼까요?
            작성한 다짐들은 랜덤 알림으로 다시 떠올릴 수 있어요.
            """
        case .freely:
            """
            형식에 구애받지 않고 마음 가는 대로 자유롭게 적어보세요.
            나만의 이야기를 부담 없이 담을 수 있는 공간입니다.
            """
        }
    }
}

// MARK: -
struct MainContentControl: Identifiable, Hashable {
    let id: UUID = .init()
    var symbol: String = ""
    var type: MainContentType
    var frame: CGRect = .zero
    var controlSize: ControlSize = .card // default (추후 업데이트)
}

var sampleControls: [MainContentControl] = [
    .init(symbol: "timer.circle.fill", type: .withinThreeMinutes),
    .init(symbol: "die.face.1.fill", type: .voiceRecording),
    .init(symbol: "sparkles", type: .resolution),
    .init(symbol: "pencil.line", type: .freely)
]

// MARK: -
enum ControlSize {
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
