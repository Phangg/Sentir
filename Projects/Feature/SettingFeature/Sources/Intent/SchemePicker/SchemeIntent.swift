//
//  SchemeIntent.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

protocol SchemeIntent: AnyObject {
    //
    var appScheme: AppScheme { get }
    //
    func tapSchemeCard(_ preview: [SchemePreview], schemeType: AppScheme)
}
