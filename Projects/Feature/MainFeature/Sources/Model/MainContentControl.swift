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
    case withinFiveMinutes = "5분의 시간"
    case oneSentence = "한 문장 요약"
    case resolution = "오늘의 다짐"
    case freely = "자유롭게 작성"
    
    var description: String {
        switch self {
        case .withinFiveMinutes:
            """
            5분의 타이머가 흘러가는 동안 작성할 수 있어요.
            """
        case .oneSentence:
            """
            한 문장으로 하루를 정리해볼까요?
            """
        case .resolution:
            """
            오늘의 다짐을 적어볼까요?
            적어놓은 다짐들은 랜덤으로 알림을 받을 수도 있어요.
            """
        case .freely:
            """
            양식에 신경쓰지 않고 글을 적을 수 있어요.
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
    .init(symbol: "timer.circle.fill", type: .withinFiveMinutes),
    .init(symbol: "die.face.1.fill", type: .oneSentence),
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
