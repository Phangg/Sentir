//
//  TabBarState.swift
//  Common
//
//  Created by phang on 10/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public final class TabBarState: ObservableObject {
    public static let shared = TabBarState()

    @Published public var isHidden: Bool = false
    
    private init() { }
    
    public func hide() {
        isHidden = true
    }
    
    public func show() {
        isHidden = false
    }
}
