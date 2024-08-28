//
//  Environment.swift
//  AppManifests
//
//  Created by phang on 8/27/24.
//

import Foundation
import ProjectDescription

public extension String {
    static let appName: String = "Sentir"
    static let displayName: String = "Sentir"
    static let organizationName: String = "Sentir"

    static let marketingVersion: Self = "1.0.0"

    static var buildVersion: Self {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.HH.mm"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: date)
    }
}

public extension Platform {
    static let current: Self = .iOS
}

extension SettingValue {
    static let marketingVersion: Self = .string(.marketingVersion)
    static let currentProjectVersion: Self = .string(.buildVersion)
}

public extension String {
    static let bundleID: Self = "com.\(organizationName).\(appName)"
    static let targetVersion: Self = "17.0"
}

public extension DeploymentTargets {
    static let deploymentTarget: Self = iOS(.targetVersion)
}

extension Plist.Value {
    static let version: Self = "1"
    static let shortVersion: Self = "0.0.1"
    
    static let bundleDisplayName: Self = .string(.displayName)
    static let bundleShortVersionString: Self = .string(.marketingVersion)
    static let bundleVersion: Self = .string(.buildVersion)
}
