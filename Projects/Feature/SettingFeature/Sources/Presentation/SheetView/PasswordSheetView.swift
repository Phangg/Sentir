//
//  PasswordSheetView.swift
//  SettingFeature
//
//  Created by phang on 9/20/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

import Common
import Core
import DesignSystem

struct PasswordSheetView: View {
    //
    @StateObject var container: MVIContainer<PasswordIntent, PasswordModelState>
    private var intent: PasswordIntent { container.intent }
    private var state: PasswordModelState { container.model }

    //
    init(
        finishSetPasswordCompletion: @escaping () -> Void
    ) {
        let model = PasswordModelImp()
        let intent = PasswordIntentImp(
            model: model,
            finishSetPasswordCompletion: finishSetPasswordCompletion
        )
        let container = MVIContainer(
            intent: intent as PasswordIntent,
            model: model as PasswordModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    
    var body: some View {
        GeometryReader { geo in
            //
            VStack {
                switch state.passwordSheetState {
                case .firstSet:
                    PasswordView(size: geo.size)
                case .recheck:
                    PasswordView(size: geo.size)
                        .modifier(
                            Shake(animatableData: state.incorrectPassword ? 1 : 0) {
                                intent.finisshShakeAnimation()
                            }
                        )
                }
            }
        }
    }
}

// MARK: - 
extension PasswordSheetView {
    @ViewBuilder
    fileprivate func PasswordView(size: CGSize) -> some View {
        VStack(alignment: .center, spacing: 20) {
            //
            Spacer(minLength: 0)
            //
            PasswordExplanationText
            //
            PasswordIndicator
                .padding(.vertical, ViewValues.halfPadding)
            //
            Spacer(minLength: 0)
            //
            PasswordKeypadButtons(buttonSize: max((size.width - 40) / 3, 60))
        }
    }
    
    @ViewBuilder
    fileprivate var PasswordExplanationText: some View {
        Text(state.passwordExplanationMainText)
            .textStyle(MediumTitle(weight: .semibold))
        
        Text(state.passwordExplanationSubText)
            .textStyle(Paragraph(color: DesignSystemAsset.darkGray))
    }
    
    @ViewBuilder
    fileprivate var PasswordIndicator: some View {
        HStack(alignment: .center, spacing: 20) {
            ForEach(0..<state.maxPasswordLength, id: \.self) { idx in
                Circle()
                    .fill(
                        idx < (state.passwordSheetState == .firstSet ?
                               state.password.count : state.passwordRecheck.count) ?
                        DesignSystemAsset.black : DesignSystemAsset.lightGray
                    )
                    .frame(width: 20)
            }
        }
    }
    
    @ViewBuilder
    private func PasswordKeypadButtons(buttonSize: CGFloat) -> some View {
        VStack(spacing: 10) {
            //
            ForEach(0..<3) { row in
                //
                HStack(spacing: 20) {
                    ForEach(1...3, id: \.self) { col in
                        let number = (row * 3) + col
                        //
                        Button {
                            intent.tapPasswordNumber(number, state: state.passwordSheetState)
                        } label: {
                            Text("\(number)")
                                .textStyle(MediumTitle(weight: .semibold,
                                                       color: DesignSystemAsset.lightGray))
                                .frame(width: buttonSize, height: 60)
                        }
                    }
                }
            }
            //
            HStack(spacing: 20) {
                //
                Text("")
                    .frame(width: buttonSize, height: 60)
                //
                Button {
                    intent.tapPasswordNumber(0, state: state.passwordSheetState)
                } label: {
                    Text("0")
                        .textStyle(MediumTitle(weight: .semibold,
                                               color: DesignSystemAsset.lightGray))
                        .frame(width: buttonSize, height: 60)
                }
                //
                Button {
                    intent.tapDeletePasswordNumber()
                } label: {
                    Image(systemName: "delete.left.fill")
                        .font(.title3)
                        .tint(DesignSystemAsset.lightGray)
                        .frame(width: buttonSize, height: 60)
                }
            }
        }
    }
}
