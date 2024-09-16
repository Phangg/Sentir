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
    @State private var journalData = JournalData.sample
    
    public init() { }
        
    public var body: some View {
        VStack {
            //
            List {
                //
                ForEach(journalData.keys.sorted(by: >), id: \.self) { dateInfo in
                    //
                    Section {
                        ForEach(journalData[dateInfo] ?? [], id: \.id) { journal in
                            VStack(alignment: .leading, spacing: 4) {
                                //
                                Text(journal.timeInfo)
                                    .textStyle(SmallParagraph(color: DesignSystemAsset.darkGray))
                                    .lineLimit(1)
                                //
                                Text(journal.content)
                                    .textStyle(Paragraph())
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 2)
                        }
                        .onDelete { indexSet in
                            deleteItem(at: indexSet, for: dateInfo)
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
            .padding(.top, 5)
        }
        .safeAreaPadding(.bottom, 70)
    }
    
    private func deleteItem(
        at indexSet: IndexSet,
        for dateInfo: String
    ) {
        if var journals = journalData[dateInfo] {
            journals.remove(atOffsets: indexSet)
            //
            if journals.isEmpty {
                journalData.removeValue(forKey: dateInfo)
            } else {
                journalData[dateInfo] = journals
            }
        }
    }
}
