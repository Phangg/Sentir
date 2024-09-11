//
//  Version.swift
//  Common
//
//  Created by phang on 9/11/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import Foundation

public struct Version {
    // 앱 버전
    public static func getAppVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let appVersion = dictionary["CFBundleShortVersionString"] as? String
        else {
            return "-"
        }
        return String(appVersion.reversed())
    }
    
    // 빌드 버전
    public static func getBuildVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let buildVersion = dictionary["CFBundleVersion"] as? String
        else {
            return "?"
        }
        return buildVersion
    }
}
