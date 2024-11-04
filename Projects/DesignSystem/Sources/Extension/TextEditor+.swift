//
//  TextEditor+.swift
//  DesignSystem
//
//  Created by phang on 11/1/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

extension TextEditor {
    //
    public func defaultCustomStyleEditor(
        _ input: Binding<String>,
        placeholder: String
    ) -> some View {
        self.modifier(DefaultCustomTextEditorStyle(text: input, placeholder: placeholder))
    }
    
    //
    public func resolutionJournalStyleEditor(
        _ input: Binding<String>,
        placeholder: String
    ) -> some View {
        self.modifier(ResolutionJournalStyleEditorStyle(text: input, placeholder: placeholder))
    }
}
