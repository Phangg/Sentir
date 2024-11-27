//
//  PasswordModel.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

// MARK: - State
protocol PasswordModelState: AnyObject {
    var password: String { get }
    var passwordRecheck: String { get }
    var passwordSheetState: PasswordSheetState { get }
    var incorrectPassword: Bool { get }
    //
    var maxPasswordLength: Int { get }
    var passwordExplanationMainText: String { get }
    var passwordExplanationSubText: String { get }
}

// MARK: - Action
protocol PasswordModelAction: AnyObject {
    func addPasswordNumber(_ number: Int)
    func isPasswordAppendable() -> Bool
    func isPasswordMaxLengthReached() -> Bool
    func isPasswordMatching() -> Bool
    func transitionToPasswordRecheck()
    func updateIncorrectPassword(_ value: Bool)
    func removeLastPasswordNumber()
    func removePasswordRecheck()
}
