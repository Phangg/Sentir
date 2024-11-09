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
import FeatureDependency

public struct ListView: View {
    @State private var journalData = JournalData.sample
    private let listType: ListViewType
    
    public init(
        listType: ListViewType
    ) {
        self.listType = listType
    }
        
    public var body: some View {
        VStack {
            //
            List {
                //
                switch listType {
                //
                case .all(sortBy: let filterState):
                    DisplayAllJournals(filterState)
                //
                case .day(dateInfo: let dateInfo):
                    DisplayJournals(dateInfo)
                //
                case .search(searchText: let searchText):
                    DisplaySearchJournals(searchText)
                }
            }
            .listStyle(.plain)
        }
        .safeAreaPadding(.bottom, ViewValues.bottomTabArea + ViewValues.largePadding)
        .navigationDestination(for: Journal.self) { journal in
            WriteJournalView(viewState: .detail,
                             journalType: journal.type,
                             journalText: journal.content)
        }
    }

    @ViewBuilder
    private func DisplayAllJournals(_ filterState: JournalFilterState) -> some View {
        let journalData = filterState == .newest ? journalData.keys.sorted(by: >) : journalData.keys.sorted(by: <)
        //
        ForEach(journalData, id: \.self) { dateInfo in
            Section {
                DisplayJournals(dateInfo)
            } header: {
                Text(dateInfo)
                    .textStyle(SmallTitle(weight: .medium,
                                          color: DesignSystemAsset.darkGray))
            }
        }
    }
    
    @ViewBuilder
    private func DisplaySearchJournals(_ searchText: String) -> some View {
        let searchData = searchJournals(for: searchText)
        //
        ForEach(searchData.keys.sorted(by: >), id: \.self) { dateInfo in
            Section {
                DisplayJournals(dateInfo)
            } header: {
                Text(dateInfo)
                    .textStyle(SmallTitle(weight: .medium,
                                          color: DesignSystemAsset.darkGray))
            }
        }
    }

    @ViewBuilder
    private func DisplayJournals(_ dateInfo: String) -> some View {
        ForEach(journalData[dateInfo] ?? [], id: \.id) { journal in
            //
            NavigationLink(value: journal) {
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
                .padding(.vertical, ViewValues.tinyPadding)
            }
        }
        .onDelete { indexSet in
            deleteItem(at: indexSet, for: dateInfo)
        }
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
    
    private func searchJournals(for text: String) -> [String: [Journal]] {
        journalData.reduce(into: [String: [Journal]]()) { result, value in
            let (dateInfo, journals) = value
            let filteredJournals = journals.filter { journal in
                journal.content.localizedCaseInsensitiveContains(text)
            }
            if !filteredJournals.isEmpty {
                result[dateInfo] = filteredJournals
            }
        }
    }
}
