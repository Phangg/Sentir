//
//  View+CustomAlert.swift
//  DesignSystem
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public extension View {
    // MARK: - CustomAlert 를 사용하기 위함
    func customAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonColor: Color = .white,
        primaryButtonAction: @escaping () -> Void,
        secondButtonTitle: String? = nil,
        secondButtonColor: Color? = nil,
        secondButtonAction: (() -> Void)? = nil
    ) -> some View {
        let alert = CustomAlert(
            isPresented: isPresented,
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryButtonColor: primaryButtonColor,
            primaryButtonAction: primaryButtonAction,
            secondButtonTitle: secondButtonTitle,
            secondButtonColor: secondButtonColor,
            secondButtonAction: secondButtonAction
        )
        return modifier(CustomAlertModifier(isPresented: isPresented, customAlert: alert))
    }
}
