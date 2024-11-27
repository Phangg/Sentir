//
//  AppSchemeRepositoryImp.swift
//  Data
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Common
import Domain

public final class AppSchemeRepositoryImp: AppSchemeRepository {
    @AppStorage("AppScheme") private var storedScheme: AppScheme = .device
    
    public init() { }
    
    public var currentScheme: AppScheme {
        storedScheme
    }
    
    public func updateScheme(_ scheme: AppScheme) {
        storedScheme = scheme
    }
}
