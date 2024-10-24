//
//  WriteJournalView.swift
//  MainFeature
//
//  Created by phang on 10/15/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI

struct WriteJournalView: View {
    var control: MainContentControl
    
    var body: some View {
        ZStack {
            switch control.type {
            case .withinFiveMinutes:
                WithinFiveMinutesJournalView()
            case .oneSentence:
                OneSentenceJournalView()
            case .resolution:
                ResolutionJournalView()
            case .freely:
                FreelyJournalView()
            }
        }
//        .navigationBarBackButtonHidden()
    }
}
