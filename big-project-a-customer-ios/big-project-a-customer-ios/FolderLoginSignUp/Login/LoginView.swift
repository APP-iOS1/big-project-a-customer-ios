//
//  LoginView.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI


// MARK: - LoginView
/// 로그인을 하는 View 입니다.
struct LoginView: View {
    // MARK: - Property Wrappers
    @Environment(\.dismiss) private var dismiss
    @State var email = ""
    @State var password = ""
    @FocusState var isInFocusEmail: Bool
    @FocusState var isInFocusPassword: Bool
    
    
    // MARK: - Properties
    
    
    // MARK: - Body LoginView
    /// LoginView의 body 입니다.
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("로그인")
                        .bold()
                        .font(.title)
                    Spacer()
                } // HStack - 로그인 text
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "globe") // Image는 Modifier Custom을 어떻게 할까..?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 20)
                        Text("안녕하세요.\n전자상점입니다.")
                            .font(.title3)
                            .bold()
                        Text("회원 서비스 이용을 위해 로그인 해주세요.")
                            .font(.footnote)
                    } // VStack - 안내문구 text
                    Spacer()
                } // HStack - 안내문구 Vstack
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 80, trailing: 20))
            
                VStack {
                    VStack(spacing: 5) {
                        TextField("이메일", text: $email)
                            .focused($isInFocusEmail)
                            .modifier(LoginTextFieldModifier())
                            .font(.subheadline)
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusEmail))
                    }
                    .padding(.bottom, 35)
                    
                    VStack(spacing: 5) {
                        SecureField("비밀번호", text: $password)
                            .focused($isInFocusPassword)
                            .modifier(LoginTextFieldModifier())
                            .font(.subheadline)
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusPassword))
                    }
                } // VStack - 이메일, 비밀번호 TextField
                
                HStack {
                    Text("아직 계정이 없으신가요?")
                        .font(.footnote)
                    NavigationLink {
                        // Going to SignupView
                        SignUpStep1View()
                    } label: {
                        Text("회원가입")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                } // HStack - 회원가입
                .padding(.top, 30)
                
                
                Spacer()
                Spacer()
                Spacer()
                
                Divider() // 로그인 버튼 구분선
                
                Button {
                    // Login action with firebase...
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .modifier(LoginButtonModifier(label: "로그인하기"))
                }
   
            } // VStack - body 바로 아래
            .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
            .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
                endEditing()
            } // onTapGesture
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // 닫기 버튼 클릭 시 로그인 뷰(시트) 사라짐.
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17)
                            .foregroundColor(.gray)
                            .fontWeight(.light)
                    } // label
                } // toolbarItem
            } // toolbar
        } // NavigationStack - 임시
    } // Body
}

// MARK: - LoginView Previews
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


// MARK: - Modifier : LoginView TextField 속성
struct LoginTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 20)
    }
}

// MARK: - Modifier : LoginView TextField 아래 Rectangle 속성
struct LoginTextFieldRectangleModifier: ViewModifier {
    let stateTyping: Bool
    func body(content: Content) -> some View {
        content
            .frame(height: 1)
            .foregroundColor(stateTyping ? .accentColor : .gray)
            .padding(.horizontal, 20)
    }
}

// MARK: - Modifier : LoginView Login Button 속성
struct LoginButtonModifier: ViewModifier {
    let label: String
    func body(content: Content) -> some View {
        content
            .foregroundColor(.accentColor)
            .frame(height: 40)
            .overlay {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
    }
}


