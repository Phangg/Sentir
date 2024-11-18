//
//  VoiceRecordingDetailView.swift
//  FeatureDependency
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct VoiceRecordingDetailView: View {
    @Binding var journalText: String
    let dateInfo: String

    var body: some View {
        VStack {
            //
            HStack(alignment: .center) {
                //
                Text(dateInfo)
                    .textStyle(Paragraph(weight: .light))
                //
                Spacer()
            }
            .padding(.horizontal, ViewValues.halfPadding)
            //
            Group {
                Text(journalText)
                    .textStyle(Paragraph())
                    .lineSpacing(10)
                    .padding(.top, ViewValues.halfPadding)
                //
                Spacer(minLength: 0)
            }
            .padding(.horizontal, ViewValues.halfPadding)
        }
    }
}
