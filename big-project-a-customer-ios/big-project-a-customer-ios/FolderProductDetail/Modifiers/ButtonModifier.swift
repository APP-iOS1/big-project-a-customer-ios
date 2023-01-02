//
//  ButtonModifier.swift
//  big-project-a-customer-ios
//
//  Created by 이원형 on 2022/12/28.
//

import SwiftUI

struct CategoryButtonModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(width:160 , height: 160)
            .background(color)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)
    }
}

struct ContentButtonModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(width:160 , height: 160)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
    }
}

struct TmpButtonModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(width:160 , height: 160)
            .background(color)
            .cornerRadius(20)
            .overlay{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("marble"), lineWidth: 2)
            }
    }
}
