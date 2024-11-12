//
//  DynamicScrollView.swift
//  DesignSystem
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public struct DynamicScrollView<Content: View>: View {
    @State private var contentHeight: CGFloat = .zero
    let content: Content
    
    public init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if contentHeight > geometry.size.height {
                ScrollView {
                    contentView
                }
            } else {
                contentView
            }
        }
    }
    
    private var contentView: some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: ContentHeightKey.self,
                        value: geometry.size.height
                    )
                }
            )
            .onPreferenceChange(ContentHeightKey.self) { height in
                self.contentHeight = height
            }
    }
}
