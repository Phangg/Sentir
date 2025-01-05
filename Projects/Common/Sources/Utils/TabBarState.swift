//
//  TabBarState.swift
//  Common
//
//  Created by phang on 10/26/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Combine

// MARK: -
@MainActor
public protocol TabBarStateManageable: AnyObject {
    //
    var isHidden: Bool { get }
    var isHiddenPublisher: Published<Bool>.Publisher { get }
    //
    func hide()
    func show()
}

// MARK: -
@MainActor
public final class TabBarState: ObservableObject, TabBarStateManageable {
    //
    public static let shared = TabBarState()
    //
    @Published public private(set) var isHidden: Bool = false
    
    public var isHiddenPublisher: Published<Bool>.Publisher {
        $isHidden
    }
    
    private init() { }
    
    public func hide() {
        isHidden = true
    }
    
    public func show() {
        isHidden = false
    }
}
