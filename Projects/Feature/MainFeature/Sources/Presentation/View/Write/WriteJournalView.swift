//
//  WriteJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct WriteJournalView: View {
    @EnvironmentObject private var tabBarState: TabBarState
    @Environment(\.dismiss) private var dismiss
    var control: MainContentControl
    
    var body: some View {
        ZStack {
            Group {
                switch control.type {
                case .withinFiveMinutes:
                    WithinFiveMinutesJournalView()
                case .oneSentence:
                    OneSentenceJournalView()
                case .resolution:
                    ResolutionJournalView()
                case .freely:
                    FreelyJournalView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar { writeJournalViewToolbarContent() }
            .onAppear {
                tabBarState.hide()
            }
            .tint(DesignSystemAsset.black)
        }
    }
    
    @ToolbarContentBuilder
    fileprivate func writeJournalViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            //
            BackButton {
                self.dismiss()
                tabBarState.show()
            }
        }
        ToolbarItem(placement: .principal) {
            //
            Text(control.type.rawValue)
                .textStyle(SmallTitle(weight: .bold))
        }
    }
}
