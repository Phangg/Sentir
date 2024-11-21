//
//  TabType.swift
//  MainTabFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

public enum TabType: Hashable, CaseIterable {
    case main
    case journal
    case setting
    
    var image: String {
        switch self {
        case .main:
            "pencil.and.scribble"
        case .journal:
            "menucard"
        case .setting:
            "gearshape"
        }
    }
}
