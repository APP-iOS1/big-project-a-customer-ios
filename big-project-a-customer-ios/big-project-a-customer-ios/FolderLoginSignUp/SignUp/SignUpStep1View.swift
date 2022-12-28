//
//  SignUpStep1View.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI

// MARK: - Extension View
/// 키보드 밖 화면 터치 시 키보드 사라지는 함수를 선언하기 위한 extension 입니다.
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

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
    @State private var isSecuredPassword = true
    @State private var isSecuredPasswordCheck = true
    
    @State var isSucceedSignUp = false // ** 서버 연동 후 필요한 코드 **
    @EnvironmentObject var signUpViewModel: SignUpViewModel // ** 서버 연동 후 필요한 코드 **
    
    
    // MARK: Methods
    // 이메일이 aaa@aaa.aa 형식인지 검사하는 함수입니다.
    func checkEmail(string: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
    }
    

    // MARK: - Body SignUpStep1View
    /// SignUpStep1View의 body 입니다.
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("이메일과 비밀번호를\n입력해 주세요.")
                        .font(.title2)
                    Spacer()
                } // HStack 입력 안내문구
                .padding(EdgeInsets(top: 30, leading: 15, bottom: 40, trailing: 15))

                VStack(spacing: 40) {
                    VStack(spacing: 5) {
                        TextField("이메일 (예: test@gmail.com)", text: $email)
                            .focused($isInFocusEmail)
                            .modifier(LoginTextFieldModifier())
                            .frame(height: 30) // TextField width 고정 <- 아이콘 크기 변경 방지
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusEmail))
                    }

                    VStack(spacing: 5) {
                        HStack {
                            // 비밀번호 숨김 아이콘일 때
                            if isSecuredPassword {
                                SecureField("비밀번호 (6자리 이상)", text: $password)
                                    .focused($isInFocusPassword) // 커서가 올라가있을 때 상태를 저장.
                                    .modifier(LoginTextFieldModifier())
                            } else { // 비밀번호 보임 아이콘일 때
                                TextField("비밀번호 (6자리 이상)", text: $password)
                                    .focused($isInFocusPassword)
                                    .modifier(LoginTextFieldModifier())
                            }

                            Button(action: {
                                // 비밀번호 보임/숨김을 설정함.
                                isSecuredPassword.toggle()
                            }) {
                                Image(systemName: self.isSecuredPassword ? "eye.slash" : "eye")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.5)
                                    .accentColor(.gray)
                            }
                            // password가 비어있지 않으면서, 6자리 이상일 때 체크 아이콘 띄움.
                            if !password.isEmpty && password.count >= 6 {
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.5)
                                    .foregroundColor(.green)
                            }
                        } // HStack - TextField, Secured Image, Check Image
                        .frame(height: 30) // TextField가 있는 HStack의 width 고정 <- 아이콘 크기 변경 방지
                        .padding(.trailing, 20)
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusPassword))
                    } // VStack - HStack과 밑줄 Rectangle

                    VStack(spacing: 5) {
                        HStack {
                            // 비밀번호 숨김 아이콘일 때
                            if isSecuredPasswordCheck {
                                SecureField("비밀번호 (6자리 이상)", text: $passwordCheck)
                                    .focused($isInFocusPasswordCheck) // 커서가 올라가있을 때 상태를 저장.
                                    .modifier(LoginTextFieldModifier())
                            } else { // 비밀번호 보임 아이콘일 때
                                TextField("비밀번호 (6자리 이상)", text: $passwordCheck)
                                    .focused($isInFocusPasswordCheck)
                                    .modifier(LoginTextFieldModifier())
                            }

                            Button(action: {
                                isSecuredPasswordCheck.toggle()
                            }) {
                                Image(systemName: self.isSecuredPasswordCheck ? "eye.slash" : "eye")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.5)
                                    .accentColor(.gray)
                            }
                            // passwordCheck가 비어있지 않으면서, password와 같으면 체크 아이콘 띄움.
                            if !passwordCheck.isEmpty && password == passwordCheck {
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.5)
                                    .foregroundColor(.green)
                            }
                        } // HStack - TextField, Secured Image, Check Image
                        .frame(height: 30) // TextField가 있는 HStack의 width 고정 <- 아이콘 크기 변경 방지
                        .padding(.trailing, 20)
                        Rectangle()
                            .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusPasswordCheck))
                    } // VStack - HStack과 밑줄 Rectangle
                } // VStack - 이메일, 비밀번호 TextField)

                Spacer()
                Divider() // 로그인 버튼 구분선

                // 회원가입 성공 시에 다음 버튼을 띄운다. ( Step3: 닉네임 설정 뷰으로 넘어가기 )
                NavigationLink {
                    SignUpStep2View(email: $email, password: $password)
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .modifier(LoginButtonModifier(label: "다음"))
                } // NavigationLink - 다음
                // TextField가 비어있거나 비밀번호 2개가 다를 경우에는 "다음" 버튼 비활성화
                .disabled(email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck || !checkEmail(string: email) ? true : false)
            } // VStack
            .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
            .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
                endEditing()
            } // onTapGesture
            .toolbar {
                ToolbarItem(placement: .principal) { // 회원가입 진행 현황 툴바
                    Text("Step2 진행 중...")
                        .font(.footnote)
                } // toolbarItem
            } // toolbar
        } // NavigationStack - 임시
    } // Body
}


// MARK: - SignUpStep1View Previews
struct SignUpStep1View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep1View()
    }
}

