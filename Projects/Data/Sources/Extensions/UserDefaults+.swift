//
//  UserDefaults+.swift
//  Data
//
//  Created by phang on 11/16/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Foundation

extension UserDefaults: StorageType {
    //
    public func getValue<T>(forKey key: String) -> T? {
        return object(forKey: key) as? T
    }
    
    //
    public func setValue<T>(_ value: T, forKey key: String) {
        set(value, forKey: key)
    }
}
