//
//  ListView.swift
//  JournalFeature
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem

public struct ListView: View {
    private var temporaryJournalData = JournalData.temporaryJournalData
    
    public init() { }
        
    public var body: some View {
        VStack {
            // TODO: - 필터링
            Text("ListView")
            
            //
            List {
                ForEach(temporaryJournalData.keys.sorted(by: >), id: \.self) { dateInfo in
                    //
                    Section {
                        ForEach(temporaryJournalData[dateInfo] ?? [], id: \.id) { journal in
                            // TODO: -
                            VStack(alignment: .leading, spacing: 4) {
                                //
                                Text(journal.timeInfo)
                                    .textStyle(SmallParagraph(
                                        color: DesignSystemAsset.darkGray))
                                    .lineLimit(1)
                                //
                                Text(journal.content)
                                    .textStyle(Paragraph())
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 4)
                        }
                    } header: {
                        Text(dateInfo)
                            .textStyle(SmallTitle(
                                weight: .medium,
                                color: DesignSystemAsset.darkGray))
                    }
                }
            }
            .listStyle(.plain)
        }
        .safeAreaPadding(.bottom, 70)
    }
}
