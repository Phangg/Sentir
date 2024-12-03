//
//  JournalView.swift
//  JournalFeature
//
//  Created by phang on 9/2/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

public struct JournalView: View {
    @StateObject var container: MVIContainer<JournalIntent, JouarnalModelState>
    private var intent: JournalIntent { container.intent }
    private var state: JouarnalModelState { container.model }
    
    //
    public init() {
        let model = JouarnalModelImp()
        let intent = JournalIntentImp(model: model)
        let container = MVIContainer(
            intent: intent as JournalIntent,
            model: model as JouarnalModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        NavigationStack {
            //
            VStack(alignment: .trailing, spacing: 0) {
                //
                switch state.currentJournalViewState {
                case .list:
                    ZStack(alignment: .topTrailing) {
                        //
                        JournalListView(listType: .all(sortBy: state.filterState))
                            .transition(.opacity)
                        //
                        VStack {
                            JournalListFilterButton
                                .zIndex(1)
                            Spacer()
                        }
                    }
                case .calendar:
                    //
                    JournalCalendarView(
                        selectedMonthAndDates: Binding(
                            get: { state.selectedMonthAndDates },
                            set: { intent.setValue($0) }
                        )
                    )
                    .transition(.opacity)
                    
                    //
                    JournalListView(
                        listType: .day(
                            dateInfo: DateFormat
                                .dateToDateInfoString(state.selectedMonthAndDates)
                        )
                    )
                }
            }
            .animation(.easeInOut, value: state.currentJournalViewState)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar { journalViewToolbarContent() }
            // TODO: - 수정 필요
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SearchView":
                    SearchView()
                default:
                    fatalError()
                }
            }
        }
        // 최신순 / 과거순
        .sheet(
            isPresented: Binding(get: { state.showFilterSheet },
                                 set: { intent.setValue($0) }),
            onDismiss: {
                intent.dismissFilterSheet()
            }, content: {
                JournalFilterView(
                    filterState: Binding(get: { state.filterState },
                                         set: { intent.setValue($0) }),
                    showFilterSheet: Binding(get: { state.showFilterSheet },
                                             set: { intent.setValue($0) })
                )
            }
        )
        //
        .tint(DesignSystemAsset.black)
    }
}

// MARK: -
extension JournalView {
    @ViewBuilder
    fileprivate var JournalListFilterButton: some View {
        //
        Button {
            intent.openFilterSheet()
        } label: {
            HStack(spacing: 6) {
                Text(state.filterState.rawValue)
                    .textStyle(Paragraph())
                Image(systemName: "chevron.down")
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
        .padding(.top, ViewValues.smallPadding)
        .padding(.horizontal, ViewValues.defaultPadding)
    }
    
    @ToolbarContentBuilder
    fileprivate func journalViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            //
            Text("기록")
                .textStyle(Title(weight: .bold))
                .padding(.horizontal, ViewValues.halfPadding)
        }
        //
        if state.currentJournalViewState == .list {
            ToolbarItem(placement: .topBarTrailing) {
                //
                NavigationLink(value: "SearchView") {
                    Image(systemName: "magnifyingglass")
                        .tint(DesignSystemAsset.black)
                }
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            //
            Button {
                intent.toggleJournalViewMode {
                    intent.resetSelectedMonthAndDates()
                }
            } label: {
                Image(systemName: state.currentJournalViewState == .list ? "calendar": "list.dash")
                    .tint(DesignSystemAsset.black)
                    .padding(.trailing, ViewValues.halfPadding)
            }
        }
    }
}
