//
//  TabBarState.swift
//  Common
//
//  Created by phang on 10/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

// MARK: -
public protocol TabBarStateManageable {
    //
    var isHidden: Bool { get }
    //
    func hide()
    func show()
}

// MARK: -
public final class TabBarState: ObservableObject, TabBarStateManageable {
    @Published public private(set) var isHidden: Bool = false
    
    public init() { }
    
    public func hide() {
        isHidden = true
    }
    
    public func show() {
        isHidden = false
    }
}
