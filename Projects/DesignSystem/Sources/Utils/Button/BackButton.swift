//
//  BackButton.swift
//  DesignSystem
//
//  Created by phang on 10/28/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common

public struct BackButton: View {
    let isCutstomView: Bool
    let action: () -> Void
    
    public init(
        isCutstomView: Bool = false,
        action: @escaping () -> Void
    ) {
        self.isCutstomView = isCutstomView
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.left")
                .font(isCutstomView ? .title2 : .none)
                .fontWeight(isCutstomView ? .none : .medium)
        }
    }
}
