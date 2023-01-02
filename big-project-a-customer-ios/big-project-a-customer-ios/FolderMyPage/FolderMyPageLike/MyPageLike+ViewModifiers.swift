//
//  MyPageLike+ViewModifiers.swift
//  big-project-a-customer-ios
//
//  Created by do hee kim on 2022/12/27.
//

import Foundation
import SwiftUI

struct PurchaseHistoryButtonModifier: ViewModifier {
    var textColor = Color.black
    // FIXME: gray 색상 좀 연하게 해야함
    var borderColor = Color("marble")
    var backgroundColor = Color.white
    var lineWidth: CGFloat = 1.5
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
            .background(backgroundColor)
    }
}

struct TextCaptionGrayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.gray)
    }
}

struct Halign: ViewModifier {
    let alignment: Alignment
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct Valign: ViewModifier {
    let alignment: Alignment
    func body(content: Content) -> some View {
        content
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Image modifier 적용 위해서 extension 사용
extension Image {
    func ImageResizeModifier(width: CGFloat = 80, height: CGFloat = 80, cornerRadius: CGFloat = 0) -> some View {
        self
            .resizable()
            .cornerRadius(cornerRadius)
            .frame(width: width, height: height)
            .aspectRatio(contentMode: .fill)
    }
}
