//
//  UIUserInterfaceStyle+.swift
//  Common
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import UIKit

public extension UIUserInterfaceStyle {
    var oppsiteInterfaceStyle: UIUserInterfaceStyle {
        return self == .dark ? .light : .dark
    }
}
