//
//  SystemStyleHelper.swift
//  Common
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import UIKit

public struct SystemStyleHelper {
    // 현재 모드 확인
    public static var currentSystemInterfaceStyle: UIUserInterfaceStyle {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return scene.windows.first?.traitCollection.userInterfaceStyle ?? .unspecified
        }
        return .unspecified
    }
}
