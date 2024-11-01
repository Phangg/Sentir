//
//  TextEditorStyle.swift
//  DesignSystem
//
//  Created by phang on 11/1/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common

public struct CustomTextEditorStyle: ViewModifier {
    @Binding var text: String
    let placeholder: String
    
    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                Text(placeholder)
                    .textStyle(Paragraph(color: text.isEmpty ? DesignSystemAsset.lightGray : .clear))
                    .lineSpacing(10)
                    .padding(.top, ViewValues.halfPadding)
                    .padding(.leading, ViewValues.smallPadding + ViewValues.tinyPadding)
            }
            .font(.callout)
            .fontWeight(.regular)
            .lineSpacing(10)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.none)
            .padding(.horizontal, ViewValues.halfPadding)
    }
}
