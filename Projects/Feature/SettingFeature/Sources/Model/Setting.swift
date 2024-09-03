//
//  Setting.swift
//  SettingFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

// MARK: - 세팅 아이템의 우측 아이콘 타입
public enum SettingType {
    case navigate
    case toggle
    case text
}

// MARK: - 세팅 아이템 모델
public enum SettingModel: String, CaseIterable {
    //
    case lock = "잠금 설정"
    case notice = "알림 설정"
    case displayMode = "다크 모드 / 라이트 모드"
    case font = "폰트 설정"
    //
    case deleteData = "데이터 삭제"
    case backUpData = "데이터 백업"
    case restoreData = "데이터 복원"
    //
    case donation = "후원하기"
    case feedback = "의견 및 피드백"
    //
    case appVersion = "앱 버전"
    case openSource = "오픈 소스"
    
    //
    var type: SettingType {
        switch self {
        case .lock, .notice:
            return .toggle
        case .deleteData, .backUpData, .restoreData, .donation,
                .feedback, .displayMode, .font, .openSource:
            return .navigate
        case .appVersion:
            return .text
        }
    }
}
