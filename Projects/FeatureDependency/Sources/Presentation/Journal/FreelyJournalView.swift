//
//  FreelyJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct FreelyJournalView: View {
    @FocusState private var focusState: Bool
    @Binding var viewState: JournalViewState
    @Binding var journalText: String
    let dateInfo: String

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: ViewValues.halfPadding) {
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
                if viewState != .detail {
                    //
                    TextEditor(text: $journalText)
                        .defaultCustomStyleEditor($journalText,
                                                  placeholder: "어제 뭐가 무너졌어..\n어쩌구 웅앵..\n하여튼 자유롭게 작성해줘")
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    //
                    DynamicScrollView {
                        Text(journalText)
                            .textStyle(Paragraph())
                            .lineSpacing(10)
                    }
                    .padding(.top, ViewValues.smallPadding)
                    .padding(.horizontal, ViewValues.halfPadding + ViewValues.smallPadding)
                }
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
