//
//  VoiceRecordingJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import AVFoundation
import Speech
import SwiftUI
import Common
import DesignSystem

struct VoiceRecordingJournalView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var showCountdown = true
    @State private var countdown: Int = 3
    @State private var textOpacity: Double = 1.0
    private let scrollToId = "SCROLL_TO_BOTTOM"

    var body: some View {
        ZStack {
            if showCountdown {
                VStack(alignment: .center, spacing: ViewValues.defaultPadding) {
                    //
                    Text("\(countdown)")
                        .textStyle(Huge(weight: .medium))
                    //
                    Text("카운트가 끝나면 음성이 텍스트로 기록됩니다")
                        .textStyle(SmallTitle(weight: .medium))
                }
            } else {
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: ViewValues.defaultPadding) {
                            //
                            if speechRecognizer.isRecording {
                                Text("음성을 기록중입니다")
                                    .textStyle(Paragraph(color: DesignSystemAsset.accent))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .opacity(textOpacity)
                                    .animation(
                                        Animation
                                            .easeInOut(duration: 1.0)
                                            .repeatForever(autoreverses: true),
                                        value: textOpacity
                                    )
                                    .onAppear {
                                        textOpacity = 0.3
                                    }
                            }
                            //
                            Text(speechRecognizer.transcript)
                                .textStyle(Paragraph())
                                .lineSpacing(10)
                                .id(scrollToId)
                            //
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, ViewValues.defaultPadding)
                    }
                    .onChange(of: speechRecognizer.transcript) { _, _ in
                        withAnimation {
                            proxy.scrollTo(scrollToId, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .onChange(of: speechRecognizer.isFinishCheckPermissions) { _, isFinished in
            if isFinished {
                Task {
                    await startCountdown()
                }
            }
        }
        .onDisappear {
            endSpeechRecognizer()
        }
        .alert("권한이 필요합니다", isPresented: $speechRecognizer.showPermissionAlert) {
            //
            Button {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            } label: {
                Text("설정으로 이동")
            }
            //
            Button(role: .cancel) {
                dismiss()
            } label: {
                Text("취소")
            }
        } message: {
            Text("음성 인식을 위해 마이크와 음성 인식 권한이 필요합니다.")
        }
    }

    private func startCountdown() async {
        for _ in 1...3 {
            HapticManager.shared.triggerImpact(style: .medium)
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            countdown -= 1
        }
        
        await MainActor.run {
            HapticManager.shared.triggerNotification(type: .warning)
        }
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        showCountdown = false
        startSpeechRecognizer()
    }
    
    private func startSpeechRecognizer() {
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
    }
    
    private func endSpeechRecognizer() {
        speechRecognizer.stopTranscribing()
    }
}
