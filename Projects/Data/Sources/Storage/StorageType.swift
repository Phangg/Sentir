//
//  StorageType.swift
//  Data
//
//  Created by phang on 11/16/24.
//  Copyright © 2024 Phang. All rights reserved.
//

public protocol StorageType {
    func getValue<T>(forKey key: String) -> T?
    func setValue<T>(_ value: T, forKey key: String)
}
