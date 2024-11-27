//
//  PasswordIntent.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import Combine

protocol PasswordIntent: AnyObject {
    //
    var finishSetPasswordPublisher: AnyPublisher<Void, Never> { get }
    var finishSetPasswordCompletion: () -> Void { get }
    //
    func tapPasswordNumber(_ number: Int, state: PasswordSheetState)
    func tapDeletePasswordNumber()
    func finisshShakeAnimation()
    func cleanUp()
}
