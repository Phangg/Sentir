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
    @State private var isShowDeleteAlert: Bool = false
    @State private var journalText: String
    @State private var viewState: JournalViewState
    let journalType: JournalType
    let dateInfo: String
    
    public init(
        viewState: JournalViewState,
        journalType: JournalType,
        journalText: String = "",
        dateInfo: String = DateFormat.monthAndDayInfoString(Date())
    ) {
        self.viewState = viewState
        self.journalType = journalType
        self.journalText = journalText
        self.dateInfo = dateInfo
    }
    
    public var body: some View {
        ZStack {
            switch journalType {
            case .withinThreeMinutes:
                WithinThreeMinutesJournalView(viewState: $viewState,
                                              journalText: $journalText,
                                              dateInfo: dateInfo)
            case .voiceRecording:
                switch viewState {
                case .create:
                    VoiceRecordingJournalView(dateInfo: dateInfo)
                case .detail:
                    VoiceRecordingDetailView(journalText: $journalText,
                                             dateInfo: dateInfo)
                case .edit:
                    fatalError("말로 남기는 기록 - 수정 불가")
                }
            case .resolution:
                ResolutionJournalView(viewState: $viewState,
                                      journalText: $journalText,
                                      dateInfo: dateInfo)
            case .freely:
                FreelyJournalView(viewState: $viewState,
                                  journalText: $journalText,
                                  dateInfo: dateInfo)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar { writeJournalViewToolbarContent() }
        .onAppear {
            tabBarState.hide()
        }
        .customAlert(
            isPresented: $isShowDeleteAlert,
            title: "기록을 삭제할까요?",
            message: "삭제 된 기록은 복구할 수 없어요!",
            primaryButtonTitle: "삭제할래요",
            primaryButtonAction: { }, // TODO: - 삭제
            secondButtonTitle: "취소")
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
            Text(journalType.title)
                .textStyle(SmallTitle(weight: .semibold))
        }
        ToolbarItem(placement: .topBarTrailing) {
            //
            if viewState == .detail, journalType.isEditable {
                Button {
                    //
                    viewState = .edit
                } label: {
                    Image(systemName: "pencil")
                        .font(.callout)
                }
            } else if viewState == .create || viewState == .edit {
                Button {
                    // TODO: - 저장
                    viewState = .detail
                } label: {
                    Image(systemName: "checkmark")
                        .font(.callout)
                }
            }
        }
        if viewState == .detail {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: - 삭제
                    isShowDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .tint(Color.red)
                        .font(.callout)
                }
            }
        }
    }
}
