//
//  DesignSystemAsset+.swift
//  DesignSystem
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - Tuist 로 생성된 asset 을 좀 더 간편하게 사용하고자 함
public extension DesignSystemAsset {
    //
    static var black: Color { DesignSystemAsset.customBlack.swiftUIColor }
    static var darkGray: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.6) }
    static var lightGray: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.3) }
    static var gray008: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.08) }
    static var gray006: Color { DesignSystemAsset.customBlack.swiftUIColor.opacity(0.06) }
    //
    static var shuttleGray: Color { DesignSystemAsset.shuttleGrayColor.swiftUIColor }
    static var geyser: Color { DesignSystemAsset.geyserColor.swiftUIColor }
    //
    static var white: Color { DesignSystemAsset.customWhite.swiftUIColor }
    //
    static var accent: Color { DesignSystemAsset.point.swiftUIColor}
}
