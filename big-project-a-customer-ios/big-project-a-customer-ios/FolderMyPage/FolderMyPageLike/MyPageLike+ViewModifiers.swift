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
    var borderColor = Color.gray
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

struct TextCaptionGrayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.gray)
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
