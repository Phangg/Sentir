//
//  PasswordSheetView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import DesignSystem

enum PasswordSheetState: Hashable {
    case firstSet
    case recheck
}

struct PasswordSheetView: View {
    @State private var password: String = ""
    @State private var passwordRecheck: String = ""
    @State private var passwordSheetState: PasswordSheetState = .firstSet
    @State private var incorrectPassword = false
    @Binding var showPasswordSheetView: Bool
    
    private let maxPasswordLength: Int = 4
    
    var body: some View {
        GeometryReader { geo in
            //
            VStack {
                switch passwordSheetState {
                case .firstSet:
                    PasswordView(size: geo.size)
                case .recheck:
                    PasswordView(size: geo.size)
                        .modifier(Shake(animatableData: CGFloat(incorrectPassword ? 1 : 0)))
                }
            }
        }
    }
    
    @ViewBuilder
        private func PasswordView(size: CGSize) -> some View {
        VStack(alignment: .center, spacing: 20) {
            //
            Spacer(minLength: 0)
            //
            PasswordExplanationText()
            //
            PasswordIndicator()
                .padding(.vertical, 10)
            //
            Spacer(minLength: 0)
            //
            PasswordKeypadButtons(buttonSize: max((size.width - 40) / 3, 60))
        }
    }
    
    @ViewBuilder
    private func PasswordExplanationText() -> some View {
        Text(passwordSheetState == .firstSet ?
             "앱 비밀번호 설정" : "비밀번호 확인")
            .textStyle(MediumTitle(weight: .semibold))
        
        Text(passwordSheetState == .firstSet ?
             "앱 실행시 입력할 비밀번호를 설정해주세요." : "입력했던 비밀번호를 다시 입력해주세요.")
            .textStyle(Paragraph(color: DesignSystemAsset.darkGray))
    }
    
    @ViewBuilder
    private func PasswordIndicator() -> some View {
        HStack(alignment: .center, spacing: 20) {
            ForEach(0..<maxPasswordLength, id: \.self) { idx in
                Circle()
                    .fill(
                        idx < (passwordSheetState == .firstSet ?
                               password.count : passwordRecheck.count) ?
                        DesignSystemAsset.black : DesignSystemAsset.lightGray
                    )
                    .frame(width: 20)
            }
        }
    }
    
    @ViewBuilder
    private func PasswordKeypadButtons(buttonSize: CGFloat) -> some View {
        VStack(spacing: 10) {
            //
            ForEach(0..<3) { row in
                //
                HStack(spacing: 20) {
                    ForEach(1...3, id: \.self) { col in
                        let number = (row * 3) + col
                        //
                        Button {
                            appendPassword(number: number)
                        } label: {
                            Text("\(number)")
                                .textStyle(MediumTitle(weight: .semibold,
                                                       color: DesignSystemAsset.lightGray))
                                .frame(width: buttonSize, height: 60)
                        }
                    }
                }
            }
            //
            HStack(spacing: 20) {
                //
                Text("")
                    .frame(width: buttonSize, height: 60)
                //
                Button {
                    appendPassword(number: 0)
                } label: {
                    Text("0")
                        .textStyle(MediumTitle(weight: .semibold,
                                               color: DesignSystemAsset.lightGray))
                        .frame(width: buttonSize, height: 60)
                }
                //
                Button {
                    deleteLastNumber()
                } label: {
                    Image(systemName: "delete.left.fill")
                        .font(.title3)
                        .tint(DesignSystemAsset.lightGray)
                        .frame(width: buttonSize, height: 60)
                }
            }
        }
    }
    
    private func isFinishButtonEnabled() -> Bool {
        switch passwordSheetState {
        case .firstSet:
            password.count == maxPasswordLength
        case .recheck:
            passwordRecheck.count == maxPasswordLength && password == passwordRecheck
        }
    }
    
    private func appendPassword(number: Int) {
        switch passwordSheetState {
        case .firstSet:
            guard password.count < maxPasswordLength else { return }
            password.append("\(number)")
            //
            if password.count == maxPasswordLength {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    passwordSheetState = .recheck
                }
            }
        case .recheck:
            guard passwordRecheck.count < maxPasswordLength else { return }
            passwordRecheck.append("\(number)")
            //
            if passwordRecheck.count == maxPasswordLength {
                if password == passwordRecheck {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showPasswordSheetView = false
                    }
                } else {
                    incorrectPassword = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        incorrectPassword = false
                    }
                }
            }
        }
    }
    
    private func deleteLastNumber() {
        switch passwordSheetState {
        case .firstSet:
            guard !password.isEmpty else { return }
            password.removeLast()
        case .recheck:
            guard !passwordRecheck.isEmpty else { return }
            passwordRecheck.removeLast()
        }
    }
}
