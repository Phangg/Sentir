//
//  AVAudioSession+.swift
//  Common
//
//  Created by phang on 11/4/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import AVFAudio

extension AVAudioSession {
    // MARK: - 오디오 권한 허용
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
