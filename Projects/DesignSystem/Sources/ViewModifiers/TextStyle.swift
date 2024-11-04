//
//  TextStyle.swift
//  DesignSystem
//
//  Created by phang on 9/4/24.
//  Copyright © 2024 Sentir. All rights reserved.
//

import SwiftUI

// MARK: - 텍스트 스타일 구조체

//
public struct Huge: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.system(size: 40))
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct Header: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct Title: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct MediumTitle: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct SmallTitle: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.body)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct Paragraph: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}

//
public struct SmallParagraph: ViewModifier {
    private var weight: Font.Weight
    private var color: Color
    
    public init(
        weight: Font.Weight = .regular,
        color: Color = DesignSystemAsset.black
    ) {
        self.weight = weight
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.caption)
            .fontWeight(weight)
            .foregroundStyle(color)
    }
}
