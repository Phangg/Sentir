//
//  AppSchemeUpdateService.swift
//  Common
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import UIKit

public protocol AppSchemeUpdateService {
    func updateAppearance(_ scheme: AppScheme)
}

public final class AppSchemeUpdateServiceImp: AppSchemeUpdateService {
    public init() { }
    
    public func updateAppearance(_ scheme: AppScheme) {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow {
            window.overrideUserInterfaceStyle = scheme == .dark ? .dark :
                                                 scheme == .light ? .light :
                                                 .unspecified
        }
    }
}
