//
//  STTRecognizerError.swift
//  Common
//
//  Created by phang on 11/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

public enum STTRecognizerError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case notPermittedToRecord
    case recognizerIsUnavailable
    
    public var message: String {
        switch self {
        case .nilRecognizer:
            "음성 인식 사용 불가 - nil"
        case .notAuthorizedToRecognize:
            "음성 인식 권한 없음"
        case .notPermittedToRecord:
            "오디오 녹음이 허용되지 않음"
        case .recognizerIsUnavailable:
            "음성 인식 사용 불가 - isUnavailable"
        }
    }
}
