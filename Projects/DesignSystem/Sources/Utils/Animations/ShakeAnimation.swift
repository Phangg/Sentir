//
//  ShakeAnimation.swift
//  DesignSystem
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - 비밀번호 틀렸을 때, 사용되는 진동? 애니메이션
public struct Shake: AnimatableModifier {
    public var animatableData: CGFloat
    private var completion: (() -> Void)?
    
    public init(
        animatableData: CGFloat = 0,
        completion: (() -> Void)? = nil
    ) {
        self.animatableData = animatableData
        self.completion = completion
    }

    public func body(content: Content) -> some View {
        content
            .offset(x: animatableData * 7) // 흔들리는 정도 조절
            .animation(
                Animation
                    .linear(duration: 0.05)
                    .repeatCount(5, autoreverses: true),
                value: animatableData
            )
            .onChange(of: animatableData) { _, newValue in
                if newValue == 0 {
                    completion?()
                }
            }
    }
}
