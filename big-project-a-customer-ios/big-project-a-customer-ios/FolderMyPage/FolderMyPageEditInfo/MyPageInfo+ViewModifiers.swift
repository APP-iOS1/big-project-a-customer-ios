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
            .shadow(color: Color.blue, radius: 3)
    }
}

struct ConfirmModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.accentColor)
            }
            .padding(.horizontal, 20)
    }
}

struct InputModifier : ViewModifier {
    var padding: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray)
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, padding)
    }
}

struct PasswordAlertModifier: ViewModifier {
    @Binding var showingAlert: Bool
    @Binding var password: String
    @Binding var password_2: String
    func body(content: Content) -> some View {
        content
            .alert("비밀번호 불일치", isPresented: $showingAlert) {
                Button("Ok") {
                    password = ""
                    password_2 = ""
                }
            } message: {
                Text("비밀번호를 다시 입력해주세요")
            }
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
                    .stroke(Color("SubColor"), lineWidth: 2)
            }
        
    }
    
}
