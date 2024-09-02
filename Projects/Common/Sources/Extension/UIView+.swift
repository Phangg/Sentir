//
//  UIView+.swift
//  Common
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - TabBar 관련
extension UIView {

    // UITabBarController 체크 & 반환
    public var tabController: UITabBarController? {
        if let tabController = sequence(first: self, next: {
            $0.next
        }).first(where: { $0 is UITabBarController }) as? UITabBarController {
            return tabController
        }
        
        return nil
    }
}
