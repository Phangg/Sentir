//
//  InfoPlist.swift
//  AppManifests
//
//  Created by phang on 8/27/24.
//

import ProjectDescription

extension InfoPlist {
    public static let appInfoPlist: Self = .extendingDefault(
        with: .baseInfoPlist
    )
    
    public static let frameworkInfoPlist: Self = .extendingDefault(
        with: .framework
    )
}

public extension [String: Plist.Value] {
    static let baseInfoPlist: Self = [
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
            ],
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "CFBundleShortVersionString": .shortVersion,
        "CFBundleVersion": .version,
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "NSSpeechRecognitionUsageDescription": "글을 기록하기 위해, 음성 인식 사용 권한을 허용하시겠습니까?",
        "NSMicrophoneUsageDescription": "글을 기록하기 위해, 마이크 사용 권한을 허용하시겠습니까?"
    ]
    
    static let framework: Self = [
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundlePackageType": "FMWK",
        "CFBundleShortVersionString": .bundleShortVersionString,
        "CFBundleVersion": .bundleVersion,
    ]
}
