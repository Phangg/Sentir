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
    @Published public var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    // 음성 인식 init
    // 첫 사용 시, 접근 권한 허용 요청
    public init() {
        recognizer = SFSpeechRecognizer()
        guard recognizer != nil else {
            transcribe(STTRecognizerError.nilRecognizer)
            return
        }
        
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw STTRecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw STTRecognizerError.notPermittedToRecord
                }
            } catch {
                transcribe(error)
            }
        }
    }
    
    // 시작
    public func startTranscribing() {
        Task {
            transcribe()
        }
    }
    
    // 리셋
    public func resetTranscript() {
        Task {
            reset()
            transcript = ""
        }
    }
    
    // 중지
    public func stopTranscribing() {
        Task {
            reset()
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
            self.task = recognizer.recognitionTask(with: request, resultHandler: { [weak self] result, error in
                self?.recognitionHandler(audioEngine: audioEngine, result: result, error: error)
            })
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
    private func recognitionHandler(audioEngine: AVAudioEngine, result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        if let result {
            transcribe(result.bestTranscription.formattedString)
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
