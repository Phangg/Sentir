//
//  JournalDetailView.swift
//  JournalFeature
//
//  Created by phang on 11/7/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import DesignSystem
import FeatureDependency

struct JournalDetailView: View {
    var type: JournalType
    
    var body: some View {
        Group {
            switch type {
            case .withinThreeMinutes:
                EmptyView()
            case .voiceRecording:
                EmptyView()
            case .resolution:
                EmptyView()
            case .freely:
                EmptyView()
            }
        }
        .tint(DesignSystemAsset.black)
    }
}
