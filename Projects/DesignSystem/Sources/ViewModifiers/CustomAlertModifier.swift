//
//  CustomAlertModifier.swift
//  DesignSystem
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

public struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let customAlert: CustomAlert
    
    public func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(isPresented: $isPresented) {
                customAlert
            }
            .transaction { transaction in
                transaction.disablesAnimations = isPresented
            }
    }
}
