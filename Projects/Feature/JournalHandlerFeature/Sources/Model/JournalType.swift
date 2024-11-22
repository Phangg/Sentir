//
//  Untitled.swift
//  FeatureDependency
//
//  Created by phang on 11/7/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: -
public enum JournalType: Hashable {
    case withinThreeMinutes
    case voiceRecording
    case resolution
    case freely
    
    public var title: String {
        switch self {
        case .withinThreeMinutes:
            "3분의 순간"
        case .voiceRecording:
            "말로 남기는 기록"
        case .resolution:
            "오늘을 위한 다짐"
        case .freely:
            "마음 가는 대로"
        }
    }
    
    public var description: String {
        switch self {
        case .withinThreeMinutes:
            """
            3분의 타이머가
            흘러가는 동안 생각을 기록해보세요
            시간의 흐름 속에서 
            떠오르는 이야기를 남길 수 있어요
            """
        case .voiceRecording:
            """
            목소리로 오늘의 감정을 남겨보세요
            텍스트로 변환되어 기록될 거에요
            말로 기록하는 순간만을 저장 할 수 있어요
            """
        case .resolution:
            """
            이루고 싶은 다짐을 적어볼까요?
            작성한 다짐들은 
            랜덤 알림으로 다시 떠올릴 수 있어요
            """
        case .freely:
            """
            형식에 구애받지 않고 
            마음 가는 대로 자유롭게 적어보세요
            나만의 이야기를 
            부담 없이 담을 수 있는 공간이에요
            """
        }
    }
    
    public var isEditable: Bool {
        switch self {
        case .resolution, .freely:
            true
        case .withinThreeMinutes, .voiceRecording:
            false
        }
    }
}
