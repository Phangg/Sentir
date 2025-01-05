//
//  SearchBarIntent.swift
//  JournalFeature
//
//  Created by phang on 12/17/24.
//  Copyright © 2024 Phang. All rights reserved.
//

protocol SearchBarIntent: AnyObject {
    func tapXmarkButton()
    func submitSearchBar(_ text: String)
    func setValue(_ searchText: String)
}
