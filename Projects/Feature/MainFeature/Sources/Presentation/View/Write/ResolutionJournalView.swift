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
    @State private var journalText: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center) {
                //
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
                    .padding(.top, 80)
                //
                Spacer()
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

