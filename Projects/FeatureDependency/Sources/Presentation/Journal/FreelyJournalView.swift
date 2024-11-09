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
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: ViewValues.halfPadding) {
                //
                HStack(alignment: .center) {
                    //
                    Text(DateFormat.monthAndDayInfoString(Date()))
                        .textStyle(Paragraph(weight: .light))
                    //
                    Spacer()
                }
                .padding(.horizontal, ViewValues.halfPadding)
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
            }
        }
        .onTapGesture {
            focusState = false
        }
        .onAppear {
            focusState = true
        }
    }
}
