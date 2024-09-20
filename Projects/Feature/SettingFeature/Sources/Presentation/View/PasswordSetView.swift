//
//  PasswordSheetView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

struct PasswordSheetView: View {
    var body: some View {
        VStack(alignment: .center) {
            //
            PasswordExplanationText()
            //
            PasswordIndicator()
        }
    }
    
    @ViewBuilder
    private func PasswordExplanationText() -> some View {
        VStack(alignment: .center, spacing: 20) {
            //
            Text("앱 비밀번호 설정")
                .textStyle(MediumTitle(weight: .semibold))
            
            Text("앱 실행시 입력할 비밀번호를 설정해주세요.")
                .textStyle(Paragraph(color: DesignSystemAsset.darkGray))
        }
    }
    
    @ViewBuilder
    private func PasswordIndicator() -> some View {
        ForEach(0..<6, id: \.self) { _ in
            Circle()
                .fill(DesignSystemAsset.lightGray)
                .frame(width: 14)
        }
    }
}
