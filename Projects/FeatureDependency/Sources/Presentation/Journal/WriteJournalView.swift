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

public struct WriteJournalView: View {
    @EnvironmentObject private var tabBarState: TabBarState
    @Environment(\.dismiss) private var dismiss
    @State private var journalText: String
    @State private var viewState: JournalViewState
    let journalType: JournalType
    
    public init(
        viewState: JournalViewState,
        journalType: JournalType,
        journalText: String = ""
    ) {
        self.viewState = viewState
        self.journalType = journalType
        self.journalText = journalText
    }
    
    public var body: some View {
        Group {
            switch journalType {
            case .withinThreeMinutes:
                WithinThreeMinutesJournalView(viewState: $viewState,
                                              journalText: $journalText)
            case .voiceRecording:
                VoiceRecordingJournalView(viewState: $viewState,
                                          journalText: $journalText)
            case .resolution:
                ResolutionJournalView(viewState: $viewState,
                                      journalText: $journalText)
            case .freely:
                FreelyJournalView(viewState: $viewState,
                                  journalText: $journalText)
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
            Text(journalType.rawValue)
                .textStyle(SmallTitle(weight: .semibold))
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: - 저장
            } label: {
                Text("저장")
                    .textStyle(Paragraph(weight: .medium))
            }
        }
    }
}
