//
//  SchemeModel.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

// MARK: - State
protocol SchemeModelState: AnyObject {
    var localSchemeState: AppScheme { get }
    var previews: [SchemePreview] { get }
}

// MARK: - Action
protocol SchemeModelAction: AnyObject {
    func updateLocalScheme(_ scheme: AppScheme)
}
