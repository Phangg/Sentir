//
//  Text+.swift
//  DesignSystem
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - 텍스트 스타일을 지정해주기 위한 textStyle 메서드
public extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
