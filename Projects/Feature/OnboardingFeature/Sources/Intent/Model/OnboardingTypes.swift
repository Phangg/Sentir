//
//  OnboardingTypes.swift
//  OnboardingFeature
//
//  Created by phang on 11/18/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import DesignSystem

// MARK: - 온보딩 페이지를 넘기는 방식
enum OnboardingPagingType {
    case scroll
    case indicatorTap
}

// MARK: - '다음' or '완료' 버튼 상태
enum OnboardingButtonType: String {
    case skip = "건너뛰기"
    case complete = "완료"
}

// MARK: - 온보딩에서 보여줄 화면
enum OnboardingPageType: Hashable, CaseIterable {
    // TODO: - 수정 필요
    case a
    case b
    case c
    
    var description: String {
        switch self {
        case .a:
            "기능 A 에 대한 설명"
        case .b:
            "기능 B 에 대한 설명"
        case .c:
            "기능 C 에 대한 설명"
        }
    }
    
    var image: DesignSystemImages {
        switch self {
        case .a:
            DesignSystemAsset.onboardingTestImage01
        case .b:
            DesignSystemAsset.onboardingTestImage02
        case .c:
            DesignSystemAsset.onboardingTestImage03
        }
    }
    
    var buttonType: OnboardingButtonType {
        switch self {
        case .a, .b:
            .skip
        case .c:
            .complete
        }
    }
}
