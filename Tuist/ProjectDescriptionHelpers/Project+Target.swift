//
//  Project+Target.swift
//  AppManifests
//
//  Created by phang on 8/28/24.
//

import ProjectDescription

public enum ModuleType {
    case app, dynamicFramework, staticFramework, feature
    
    var product: Product {
        switch self {
        case .app:
            return .app
        case .dynamicFramework:
            return .framework
        case .staticFramework, .feature:
            return .staticFramework
        }
    }
}
