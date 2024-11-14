//
//  ResolutionJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct ResolutionJournalView: View {
    @FocusState private var focusState: Bool
    @Binding var viewState: JournalViewState
    @Binding var journalText: String
    let dateInfo: String

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: ViewValues.halfPadding) {
                //
                Text(dateInfo)
                    .textStyle(Paragraph(weight: .light))
                    .padding(.top, 80)
                    .padding(.horizontal, ViewValues.largePadding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //
                if viewState != .detail {
                    TextEditor(text: $journalText)
                        .resolutionJournalStyleEditor($journalText,
                                                      placeholder: "오늘의 다짐을 남긴다면 아마도 그건..")
                        .focused($focusState)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button {
                                    focusState = false
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                    Text("키보드 내리기")
                                        .textStyle(Paragraph(weight: .light))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                } else {
                    //
                    VStack {
                        DynamicScrollView {
                            Text(journalText)
                                .textStyle(Paragraph())
                                .lineSpacing(10)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(ViewValues.halfPadding)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(DesignSystemAsset.gray006)
                    }
                    .padding(.horizontal, ViewValues.largePadding)
                }
                //
                Spacer()
            }
        }
        .onTapGesture {
            if viewState != .detail {
                focusState = false
            }
        }
        .onAppear {
            if viewState != .detail {
                focusState = true
            }
        }
        .onChange(of: viewState) { _, newValue in
            switch newValue {
            case .detail:
                focusState = false
            case .edit:
                focusState = true
            default:
                break
            }
        }
    }
}

