//
//  TextEditorStyle.swift
//  DesignSystem
//
//  Created by phang on 11/1/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common

// MARK: - 기본
public struct DefaultCustomTextEditorStyle: ViewModifier {
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

// MARK: - 한 문장 요약에서 쓸 텍스트 에디터
public struct OneSentenceCustomTextEditorStyle: ViewModifier {
    @Binding var text: String
    let placeholder: String
    
    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                Text(placeholder)
                    .textStyle(Paragraph(color: text.isEmpty ? DesignSystemAsset.lightGray : .clear))
                    .lineSpacing(10)
                    .padding(.top, ViewValues.halfPadding + ViewValues.halfPadding)
                    .padding(.leading, ViewValues.smallPadding + ViewValues.tinyPadding + ViewValues.halfPadding)
            }
            .font(.callout)
            .fontWeight(.regular)
            .lineSpacing(10)
            .contentMargins(ViewValues.halfPadding)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.none)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(DesignSystemAsset.gray006)
            }
            .padding(.horizontal, ViewValues.largePadding)
    }
}
