//
//  WithinThreeMinutesJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

struct WithinThreeMinutesJournalView: View {
    @FocusState private var focusState: Bool
    @State private var progress: CGFloat = 0
    @State private var timer: Timer?
    @State private var totalTime: CGFloat = 3
    @State private var extensionCount: Int = 0
    @Binding var viewState: JournalViewState
    @Binding var journalText: String
    private let maxExtensions = 4

    var body: some View {
        ZStack {
            VStack(spacing: ViewValues.halfPadding) {
                //
                VStack(alignment: .leading, spacing: ViewValues.halfPadding) {
                    //
                    if viewState != .detail {
                        TimeProgressView
                    }
                    //
                    HStack(alignment: .center) {
                        //
                        Text(DateFormat.monthAndDayInfoString(Date()))
                            .textStyle(Paragraph(weight: .light))
                        //
                        Spacer()
                        //
                        if viewState != .detail {
                            Button {
                                clickAddTimeButton()
                            } label: {
                                Text("+ 30초")
                                    .textStyle(Paragraph(weight: .medium))
                                    .strikethrough(extensionCount >= maxExtensions,
                                                   color: DesignSystemAsset.black)
                                    .opacity(extensionCount >= maxExtensions ? 0.3 : 1.0)
                            }
                            .disabled(extensionCount >= maxExtensions)
                        }
                    }
                    .padding(.horizontal, ViewValues.halfPadding)
                }
                //
                if viewState != .detail {
                    //
                    TextEditor(text: $journalText)
                        .defaultCustomStyleEditor($journalText,
                                                  placeholder: "음.. 오늘은 어떤 하루였고 이러쿵 저러쿵..")
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
        .onTapGesture {
            if viewState != .detail {
                focusState = false
            }
        }
        .onAppear {
            if viewState != .detail {
                startTimer()
                focusState = true
            }
        }
        .onDisappear {
            if viewState != .detail {
                cancelTimer()
            }
        }
    }
    
    @ViewBuilder
    fileprivate var TimeProgressView: some View {
        HStack {
            Rectangle()
                .fill(DesignSystemAsset.accent.opacity(0.3))
                .frame(width: ViewValues.width, height: 8)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(DesignSystemAsset.accent)
                        .frame(width: ViewValues.width * progress, height: 7.8)
                        .animation(.linear(duration: 0.1), value: progress)
                }
        }
    }
    
    private func clickAddTimeButton() {
        totalTime += 0.5
        extensionCount += 1
        
        let elapsedTime = progress * (totalTime - 0.5) * 60
        progress = elapsedTime / (totalTime * 60)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            withAnimation(.linear(duration: 0.1)) {
                if progress < 1.0 {
                    progress += 0.1 / (totalTime * 60)
                } else {
                    cancelTimer()
                }
            }
        }
    }
    
    private func cancelTimer() {
        timer?.invalidate()
    }
}
