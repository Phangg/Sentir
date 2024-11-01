//
//  TextEditor+.swift
//  DesignSystem
//
//  Created by phang on 11/1/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

extension TextEditor {
    public func customStyleEditor(
        _ input: Binding<String>,
        placeholder: String
    ) -> some View {
        self.modifier(CustomTextEditorStyle(text: input, placeholder: placeholder))
    }
}
