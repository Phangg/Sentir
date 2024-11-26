//
//  Scheme.swift
//  Common
//
//  Created by phang on 9/3/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - 앱 스키마 ( 테마 )
public enum AppScheme: String {
    case light = "라이트 모드"
    case dark = "다크 모드"
    case device = "사용자 기기 설정 모드"
}

// MARK: - 앱 스키마 미리보기 전용 구조체 (현재 Setting 에서 사용)
public struct SchemePreview: Identifiable {
    public var id: UUID = .init()
    public var image: UIImage?
    public var text: String
    
    public init(
        image: UIImage?,
        text: String
    ) {
        self.image = image
        self.text = text
    }
}
