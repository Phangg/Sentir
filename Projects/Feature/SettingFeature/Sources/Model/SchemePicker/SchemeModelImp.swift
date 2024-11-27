//
//  SchemeModelImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation
import Common

final class SchemeModelImp: ObservableObject, SchemeModelState {
    //
    @Published private(set) var localSchemeState: AppScheme
    private(set) var previews: [SchemePreview]
    
    //
    init(
        localSchemeState: AppScheme = .device,
        previews: [SchemePreview]
    ) {
        self.localSchemeState = localSchemeState
        self.previews = previews
    }
}

extension SchemeModelImp: SchemeModelAction {
    func updateLocalScheme(_ scheme: AppScheme) {
        localSchemeState = scheme
    }
}
