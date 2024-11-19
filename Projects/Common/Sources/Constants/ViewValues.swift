//
//  ViewValues.swift
//  Common
//
//  Created by phang on 11/19/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public struct ViewValues {
    // MARK: - Padding
    public static let defaultPadding: CGFloat = 20
    public static let halfPadding: CGFloat = 10
    //
    public static let largePadding: CGFloat = 30
    public static let mediumPadding: CGFloat = 15
    public static let smallPadding: CGFloat = 5
    //
    public static let tinyPadding: CGFloat = 2
    //
    public static let bottomTabArea: CGFloat = 40
    
    // MARK: - Width / Height
    public static let width = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    
    // MARK: - Main : ControlSize
    public static let fourByFour = CGSize(width: width - (defaultPadding * 2),
                                          height: width - (defaultPadding * 2))
    public static let fourBytwo = CGSize(width: width - (defaultPadding * 2),
                                         height: (width - (defaultPadding * 3)) / 2)
    public static let twoByTwo = CGSize(width: (width - (defaultPadding * 3)) / 2,
                                        height: (width - (defaultPadding * 3)) / 2)
    public static let twoByFour = CGSize(width: (width - (defaultPadding * 3)) / 2,
                                         height: width - (defaultPadding * 2))
    //
    public static let cardSize = CGSize(width: width - (defaultPadding * 2),
                                        height: height / 4)
}
