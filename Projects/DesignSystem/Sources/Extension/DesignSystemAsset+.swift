//
//  DesignSystemAsset+.swift
//  DesignSystem
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - Tuist 로 생성된 asset 을 좀 더 간편하게 사용하고자 함
extension DesignSystemAsset {
    //
    public static var black: Color { DesignSystemAsset.customBlack.swiftUIColor }
    public static var darkGray: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.6) }
    public static var lightGray: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.3) }
    public static var gray008: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.08) }
    public static var gray006: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.06) }
    //
    public static var white: Color { DesignSystemAsset.customWhite.swiftUIColor }
}
