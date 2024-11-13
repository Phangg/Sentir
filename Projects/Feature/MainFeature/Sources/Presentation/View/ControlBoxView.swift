//
//  ControlBoxView.swift
//  MainFeature
//
//  Created by phang on 11/13/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct ControlBoxView: View {
    var control: JournalContentControl
    
    var body: some View {
        //
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                //
                Text(control.type.rawValue)
                    .textStyle(MediumTitle(weight: .bold,
                                           color: DesignSystemAsset.shuttleGray))
                //
                CustomDivider(color: DesignSystemAsset.shuttleGray,
                              type: .horizontal(height: 2))
                //
                Text(control.type.description)
                    .textStyle(Paragraph(weight: .medium,
                                         color: DesignSystemAsset.shuttleGray))
                    .lineSpacing(5)
                    .multilineTextAlignment(.leading)
            }
            .padding(ViewValues.defaultPadding)
        }
        .frame(width: control.controlSize.size.width,
               height: control.controlSize.size.height)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(DesignSystemAsset.geyser)
        }
    }
}
