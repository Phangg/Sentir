//
//  AppSchemeUseCase.swift
//  Domain
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common

public protocol AppSchemeUseCase {
    var currentScheme: AppScheme { get }
    func updateScheme(_ scheme: AppScheme)
}
