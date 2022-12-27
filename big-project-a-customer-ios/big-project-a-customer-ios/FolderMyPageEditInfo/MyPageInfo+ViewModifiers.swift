//
//  ViewModifiers.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import Foundation
import SwiftUI


struct NameModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            
    }
}

struct SayHelloModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
    }
}

struct GiftModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 400, height: 100)
            .border(.black)
            .background(.white)
    }
}

struct ProfileModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color(red: 0.0, green: 0.284, blue: 0.284), lineWidth: 1)
            }
            .shadow(color: Color.blue, radius: 5)
    }
}




struct ConfirmModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .frame(width:330, height: 100)
            .background(.white)
            .foregroundColor(.accentColor)
            .shadow(radius: 3)
    }
}


struct InputModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300,height: 40)
            .padding()
            .border(.black)
    }
}
