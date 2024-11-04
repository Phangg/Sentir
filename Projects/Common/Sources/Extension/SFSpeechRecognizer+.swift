//
//  SFSpeechRecognizer+.swift
//  Common
//
//  Created by phang on 11/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Speech

extension SFSpeechRecognizer {
    // MARK: - 권한 체크
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}
