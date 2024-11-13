//
//  CustomDivider.swift
//  DesignSystem
//
//  Created by phang on 11/13/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public struct CustomDivider: View {
    let color: Color
    let type: DividerType
    
    public init(
        color: Color,
        type: DividerType
    ) {
        self.color = color
        self.type = type
    }
    
    public var body: some View {
        switch type {
        case .horizontal(let height):
            color
                .frame(height: height)
        case .vertival(let width):
            color
                .frame(width: width)
        }
    }
}
