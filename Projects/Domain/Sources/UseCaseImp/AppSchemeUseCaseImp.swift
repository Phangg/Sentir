//
//  AppSchemeUseCaseImp.swift
//  Domain
//
//  Created by phang on 11/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

import Common

public class AppSchemeUseCaseImp: AppSchemeUseCase {
    private let appSchemeRepository: AppSchemeRepository
    
    public init(appSchemeRepository: AppSchemeRepository) {
        self.appSchemeRepository = appSchemeRepository
    }
    
    public var currentScheme: AppScheme {
        appSchemeRepository.currentScheme
    }
    
    public func updateScheme(_ scheme: AppScheme) {
        appSchemeRepository.updateScheme(scheme)
    }
}
