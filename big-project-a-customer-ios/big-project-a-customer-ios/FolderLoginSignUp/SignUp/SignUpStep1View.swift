//
//  SignUpStep1View.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI

// MARK: - SignUpStep1View
///이메일과 비밀번호를 설정하는 View 입니다.
struct SignUpStep1View: View {
    // MARK: - Property Wrappers
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @FocusState var isInFocusEmail: Bool
    @FocusState var isInFocusPassword: Bool
    @FocusState var isInFocusPasswordCheck: Bool
    
    
    // MARK: - Body SignUpStep1View
    /// SignUpStep1View의 body 입니다.
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("이메일과 비밀번호를\n입력해 주세요.")
                        .font(.title2)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15))
                
                VStack(spacing: 40) {
                    VStack(spacing: 5) {
                        TextField("이메일 (예: test@gmail.com)", text: $email)
                            .focused($isInFocusEmail)
                            .modifier(LoginTextFieldModifier())
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusEmail))
                    }
                    
                    VStack(spacing: 5) {
                        SecureField("비밀번호 (6자리 이상)", text: $password)
                            .focused($isInFocusPassword)
                            .modifier(LoginTextFieldModifier())
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusPassword))
                    }
                    
                    VStack(spacing: 5) {
                        SecureField("비밀번호 확인", text: $passwordCheck)
                            .focused($isInFocusPasswordCheck)
                            .modifier(LoginTextFieldModifier())
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusPasswordCheck))
                    }
                } // VStack - 이메일, 비밀번호 TextField)
                
                Spacer()
                Divider() // 로그인 버튼 구분선
                
                Button {
                    // Login action with firebase...
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .modifier(LoginButtonModifier())
                }
            } // VStack
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Step2 진행 중...")
                        .font(.footnote)
                } // toolbarItem
        }
        } // toolbar
    } // body
}

struct SignUpStep1View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep1View()
    }
}

