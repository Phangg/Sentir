//
//  JournalListView.swift
//  JournalFeature
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

public struct JournalListView: View {
    @EnvironmentObject var container: MVIContainer<JournalIntent, JournalModelState>
    private var intent: JournalListIntent { container.intent }
    private var state: JournalListModelState { container.model }
        
    public var body: some View {
        VStack {
            //
            List {
                switch state.listType {
                //
                case .all:
                    DisplayAllJournals()
                //
                case .day(dateInfo: let dateInfo):
                    DisplayJournals(forDate: dateInfo, inData: state.journals)
                //
                case .search(searchedJournals: let searchedJournals):
                    DisplaySearchJournals(searchedJournals)
                }
            }
            .listStyle(.plain)
        }
        .safeAreaPadding(.bottom, ViewValues.bottomTabArea + ViewValues.largePadding)
    }

    @ViewBuilder
    fileprivate func DisplayAllJournals() -> some View {
        let journals = state.filterState == .newest
        ? state.journals.keys.sorted(by: >)
        : state.journals.keys.sorted(by: <)
        //
        ForEach(journals, id: \.self) { dateInfo in
            Section {
                DisplayJournals(forDate: dateInfo, inData: state.journals)
            } header: {
                Text(dateInfo)
                    .textStyle(SmallTitle(weight: .medium,
                                          color: DesignSystemAsset.darkGray))
            }
        }
    }
    
    @ViewBuilder
    fileprivate func DisplaySearchJournals(_ searchedJournals: [String: [Journal]]) -> some View {
        //
        ForEach(searchedJournals.keys.sorted(by: >), id: \.self) { dateInfo in
            Section {
                DisplayJournals(forDate: dateInfo, inData: searchedJournals)
            } header: {
                Text(dateInfo)
                    .textStyle(SmallTitle(weight: .medium,
                                          color: DesignSystemAsset.darkGray))
            }
        }
    }

    @ViewBuilder
    fileprivate func DisplayJournals(
        forDate dateInfo: String,
        inData journals: [String: [Journal]]
    ) -> some View {
        ForEach(journals[dateInfo] ?? [], id: \.id) { journal in
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
            .simultaneousGesture(TapGesture().onEnded {
                print("NavigationLink tapped:", journal)
            })
        }
        .onDelete { indexSet in
            intent.deleteJournalItem(at: indexSet, for: dateInfo)
//            deleteItem(at: indexSet, for: dateInfo)
        }
    }

//    private func deleteItem(
//        at indexSet: IndexSet,
//        for dateInfo: String
//    ) {
//        if var journals = state.journals[dateInfo] {
//            journals.remove(atOffsets: indexSet)
//            //
//            if journals.isEmpty {
////                state.journals.removeValue(forKey: dateInfo)
//            } else {
////                state.journals[dateInfo] = journals
//            }
//        }
//    }
}
