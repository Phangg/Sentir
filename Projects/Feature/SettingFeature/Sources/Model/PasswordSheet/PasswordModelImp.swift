//
//  PasswordModelImp.swift
//  SettingFeature
//
//  Created by phang on 11/27/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

final class PasswordModelImp: ObservableObject, PasswordModelState {
    //
    @Published private(set) var password: String
    @Published private(set) var passwordRecheck: String
    @Published private(set) var passwordSheetState: PasswordSheetState
    @Published private(set) var incorrectPassword: Bool
    //
    let maxPasswordLength: Int = 4
    var passwordExplanationMainText: String
    var passwordExplanationSubText: String

    //
    init(
        password: String = "",
        passwordRecheck: String = "",
        passwordSheetState: PasswordSheetState = .firstSet,
        incorrectPassword: Bool = false,
        passwordExplanationMainText: String = "앱 비밀번호 설정",
        passwordExplanationSubText: String = "앱 실행시 입력할 비밀번호를 설정해주세요."
    ) {
        self.password = password
        self.passwordRecheck = passwordRecheck
        self.passwordSheetState = passwordSheetState
        self.incorrectPassword = incorrectPassword
        self.passwordExplanationMainText = passwordExplanationMainText
        self.passwordExplanationSubText = passwordExplanationSubText
    }
    
    //
    private func updatePasswordExplanationText() {
        passwordExplanationMainText = passwordSheetState == .firstSet ?
        "앱 비밀번호 설정" : "비밀번호 확인"
        passwordExplanationSubText = passwordSheetState == .firstSet ?
        "앱 실행시 입력할 비밀번호를 설정해주세요." : "입력했던 비밀번호를 다시 입력해주세요."
    }
}

extension PasswordModelImp: PasswordModelAction {
    //
    func addPasswordNumber(_ number: Int) {
        switch passwordSheetState {
        case .firstSet:
            password.append("\(number)")
        case .recheck:
            passwordRecheck.append("\(number)")
        }
    }
    
    func isPasswordAppendable() -> Bool {
        switch passwordSheetState {
        case .firstSet:
            password.count < maxPasswordLength
        case .recheck:
            passwordRecheck.count < maxPasswordLength
        }
    }
    
    func isPasswordMaxLengthReached() -> Bool {
        switch passwordSheetState {
        case .firstSet:
            password.count == maxPasswordLength
        case .recheck:
            passwordRecheck.count == maxPasswordLength
        }
    }
    
    func isPasswordMatching() -> Bool {
        password == passwordRecheck
    }
    
    func transitionToPasswordRecheck() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.passwordSheetState = .recheck
            self?.updatePasswordExplanationText()
        }
    }
    
    func updateIncorrectPassword(_ value: Bool) {
        incorrectPassword = value
    }
    
    func removeLastPasswordNumber() {
        switch passwordSheetState {
        case .firstSet:
            guard !password.isEmpty else { return }
            password.removeLast()
        case .recheck:
            guard !passwordRecheck.isEmpty else { return }
            passwordRecheck.removeLast()
        }
    }
    
    func removePasswordRecheck() {
        passwordRecheck = ""
    }
}
