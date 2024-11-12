//
//  View+transparentFullScreenCover.swift
//  DesignSystem
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public extension View {
    // 투명 배경 Full Screen Cover
    func transparentFullScreenCover<Content: View>(
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
}
