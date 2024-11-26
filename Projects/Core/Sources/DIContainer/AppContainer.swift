//
//  AppContainer.swift
//  Core
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

public final class AppContainer {
    public static let shared = AppContainer()
    private var dependencies: [String: Any] = [:]
    private var factories: [String: (AppContainer) -> Any] = [:]
    
    private init() { }
    
    public func register<T>(type: T.Type, _ factory: @escaping (AppContainer) -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    public func register<T>(type: T.Type, _ dependency: T) {
        let key = String(describing: type)
        dependencies[key] = dependency
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        if let factory = factories[key] {
            return factory(self) as! T
        }
        guard let dependency = dependencies[key] as? T else {
            fatalError("등록되지 않은 객체 호출 - \(key)")
        }
        return dependency
    }
}
