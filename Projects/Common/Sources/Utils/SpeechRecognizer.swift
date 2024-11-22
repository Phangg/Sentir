//
//  SpeechRecognizer.swift
//  Common
//
//  Created by phang on 11/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import AVFoundation
import Speech
import SwiftUI

@MainActor
public class SpeechRecognizer: ObservableObject {
    @Published public private(set) var transcript: String = ""
    @Published public private(set) var isRecording = false
    @Published public private(set) var isFinishCheckPermissions = false
    @Published public var showPermissionAlert = false

    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    // 음성 인식 init
    public init() {
        recognizer = SFSpeechRecognizer()
        guard recognizer != nil else {
            transcribe(STTRecognizerError.nilRecognizer)
            return
        }
        
        // 접근 권한 허용 요청
        Task {
            guard await checkAndRequestPermissions() else {
                return
            }
            isFinishCheckPermissions = true
        }
    }
    
    // 권한 체크 및 요청 메서드
    public func checkAndRequestPermissions() async -> Bool {
        let speechAuthorized = await SFSpeechRecognizer.hasAuthorizationToRecognize()
        let audioAuthorized = await AVAudioSession.sharedInstance().hasPermissionToRecord()
        
        guard speechAuthorized && audioAuthorized else {
            showPermissionAlert = true
            transcribe(STTRecognizerError.notAuthorizedToRecognize)
            return false
        }
        return true
    }
    
    // 시작 및 권한 다시 체크
    public func startTranscribing() {
        Task {
            guard await checkAndRequestPermissions() else { return }
            transcribe()
            isRecording = true
        }
    }

    // 리셋
    public func resetTranscript() {
        Task {
            reset()
            transcript = ""
            isRecording = false
        }
    }
    
    // 중지
    public func stopTranscribing() {
        Task {
            reset()
            isRecording = false
        }
    }
    
    // SFSpeechRecognitionTask 를 생성하여 음성을 텍스트로 변환
    // stopTranscribing() 를 호출할 때까지 계속 진행
    // transcript 에 기록
    private func transcribe() {
        guard let recognizer, recognizer.isAvailable else {
            self.transcribe(STTRecognizerError.recognizerIsUnavailable)
            return
        }
        
        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            
            self.task = recognizer.recognitionTask(with: request) { [weak self] result, error in
                self?.recognitionHandler(audioEngine: audioEngine, result: result, error: error)
            }
        } catch {
            self.reset()
            self.transcribe(error)
        }
    }
    
    // 음성 인식 및 오디오 엔진 리셋
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    // 오디오 엔진 준비 및 요청 설정
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    // 음성 인식 결과 처리
    private func recognitionHandler(
        audioEngine: AVAudioEngine,
        result: SFSpeechRecognitionResult?,
        error: Error?
    ) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            isRecording = false
        }
        
        if let result {
            transcribe(result.bestTranscription.formattedString)
        }
        
        if let error {
            transcribe(error)
        }
    }
    
    // 음성을 텍스트로 변환
    private func transcribe(_ message: String) {
        transcript = message
    }

    // 오류 메시지 변환
    private func transcribe(_ error: Error) {
        var errorMessage = ""
        if let error = error as? STTRecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
}
