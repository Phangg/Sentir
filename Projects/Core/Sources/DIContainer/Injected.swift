//
//  Injected.swift
//  Core
//
//  Created by phang on 11/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

@propertyWrapper
public struct Injected<T> {
    private let container: AppContainer
    private var type: T.Type
    
    public var wrappedValue: T {
        container.resolve(type)
    }
    
    public init(
        _ type: T.Type,
        container: AppContainer = AppContainer.shared
    ) {
        self.type = type
        self.container = container
    }
}
