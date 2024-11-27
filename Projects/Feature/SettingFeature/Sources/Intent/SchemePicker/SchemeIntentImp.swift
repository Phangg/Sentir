//
//  SchemeIntentImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Common
import Core
import Domain

final class SchemeIntentImp {
    //
    private weak var model: SchemeModelAction?
    //
    @Injected(AppSchemeUseCase.self)
    private var appSchemeUseCase: AppSchemeUseCase
    @Injected(AppSchemeUpdateService.self)
    private var appSchemeUpdateService: AppSchemeUpdateService
    
    //
    init(
        model: SchemeModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension SchemeIntentImp: SchemeIntent {
    //
    var appScheme: AppScheme {
        appSchemeUseCase.currentScheme
    }
    
    //
    func tapSchemeCard(_ preview: [SchemePreview], schemeType: AppScheme) {
        if schemeType == .device {
            appSchemeUseCase.updateScheme(schemeType)
        } else {
            let schemeType = preview.first?.text == AppScheme.dark.rawValue ? AppScheme.dark : AppScheme.light
            appSchemeUseCase.updateScheme(schemeType)
        }
        appSchemeUpdateService.updateAppearance(appScheme)
        
        model?.updateLocalScheme(appScheme)
    }
}
