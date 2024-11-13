//
//  CustomAlert.swift
//  DesignSystem
//
//  Created by phang on 11/12/24.
//  Copyright © 2024 Phang. All rights reserved.
//

import SwiftUI
import Common

public struct CustomAlert: View {
    @State private var backgroundOpacity: CGFloat = 0.0
    @State private var zStackOffset = ViewValues.height / 2
    //
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let primaryButtonTitle: String
    let primaryButtonColor: Color
    let primaryButtonAction: (() -> Void)
    let secondButtonTitle: String?
    let secondButtonColor: Color?
    let secondButtonAction: (() -> Void)?
    //
    private let viewWidth = ViewValues.width - (ViewValues.largePadding * 2)

    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonColor: Color = DesignSystemAsset.white,
        primaryButtonAction: @escaping () -> Void,
        secondButtonTitle: String? = nil,
        secondButtonColor: Color? = nil,
        secondButtonAction: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonColor = primaryButtonColor
        self.primaryButtonAction = primaryButtonAction
        self.secondButtonTitle = secondButtonTitle
        self.secondButtonColor = secondButtonColor
        self.secondButtonAction = secondButtonAction
    }
    
    public var body: some View {
        ZStack {
            //
            DesignSystemAsset.black
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.15), value: backgroundOpacity)
            //
            ZStack {
                VStack(spacing: 0) {
                    //
                    VStack(spacing: ViewValues.defaultPadding) {
                        Text(title)
                            .textStyle(SmallTitle(weight: .semibold))
                            .multilineTextAlignment(.center)
                        if let message = message {
                            Text(message)
                                .textStyle(Paragraph())
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, ViewValues.largePadding)
                    .padding(.bottom, ViewValues.halfPadding)
                    //
                    HStack(spacing: ViewValues.halfPadding) {
                        //
                        if let secondButtonTitle = secondButtonTitle {
                            Button {
                                dismiss()
                                secondButtonAction?()
                            } label: {
                                Capsule()
                                    .fill(DesignSystemAsset.lightGray)
                                    .overlay {
                                        Text(secondButtonTitle)
                                            .textStyle(Paragraph(weight: .semibold,
                                                                 color: secondButtonColor ?? DesignSystemAsset.white))
                                    }
                            }
                            .frame(width: getButtonWidth(ratio: 0.3), height: 50)
                        }
                        //
                        Button {
                            dismiss()
                            primaryButtonAction()
                        } label: {
                            Capsule()
                                .fill(DesignSystemAsset.black)
                                .overlay {
                                    Text(primaryButtonTitle)
                                        .textStyle(Paragraph(weight: .semibold,
                                                             color: primaryButtonColor))
                                }
                        }
                        .frame(width: getButtonWidth(ratio: 0.7), height: 50)
                    }
                    .frame(width: viewWidth - (ViewValues.defaultPadding * 2))
                    .padding(.vertical, ViewValues.defaultPadding)
                    .padding(.bottom, ViewValues.halfPadding)
                }
                .padding(.horizontal, ViewValues.defaultPadding)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(DesignSystemAsset.white)
            }
            .frame(width: viewWidth)
            .offset(y: zStackOffset)
            .animation(.spring(response: 0.3, dampingFraction: 0.75), value: zStackOffset)
        }
        .onAppear {
            backgroundOpacity = 0.4
            zStackOffset = 0
        }
    }
    
    private func dismiss() {
        backgroundOpacity = 0
        zStackOffset = ViewValues.height / 2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPresented.toggle()
        }
    }
    
    private func getButtonWidth(ratio: CGFloat) -> CGFloat {
        let buttonStackWidth = viewWidth - (ViewValues.defaultPadding * 2) - (ViewValues.halfPadding)
        return buttonStackWidth * ratio
    }
}
