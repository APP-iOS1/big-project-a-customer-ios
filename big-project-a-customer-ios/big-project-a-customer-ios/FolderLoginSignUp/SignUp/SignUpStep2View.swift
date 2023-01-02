//
//  SignUpStep2View.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI
import PopupView


// MARK: - SignUpStep2View
///닉네임을 설정하는 View 입니다.
struct SignUpStep2View: View {
    
    // MARK: - Property Wrappers
    @Environment(\.dismiss) private var dismiss
    //	@Binding var isLoginSheet: Bool
    @Binding var email: String
    @Binding var password: String
    @State var nickName = ""
    @FocusState var isInFocusNickName: Bool
    @State private var isShowSucceedToast = false
    @Binding var navStack: NavigationPath
    
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    
    // MARK: - Methods
    // ** 서버 연동 후 필요한 코드 **
    // Firebase Authentication에 계정을 생성하고 성공 유무를 isSucceedSignUp에 담는 함수입니다.
    private func signUpWithEmailPassword() {
        Task {
            if await signUpViewModel.createUser(email: email, password: password, nickname: nickName) {
                navStack = .init() // 루트뷰(로그인뷰)로 돌아가기
                print("회원가입 성공")
            } else {
                
                print("회원가입 실패")
            }
        }
    }
    
    
    // MARK: - Body SignUpStep2View
    /// SignUpStep2View의 body 입니다.
    var body: some View {

        VStack {
            HStack {
                Text("닉네임을\n입력해 주세요.")
                    .font(.title2)
                Spacer()
            } // HStack 입력 안내문구
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 40, trailing: 15))
            
            VStack(spacing: 5) {
                TextField("닉네임 (6자리 이내)", text: $nickName)
                    .focused($isInFocusNickName)
                    .modifier(LoginTextFieldModifier())
                    .frame(height: 30)
                Rectangle()
                    .modifier(LoginTextFieldRectangleModifier(stateTyping: isInFocusNickName))
            } // VStack TextField 닉네임
            
            Spacer()
            Divider() // 로그인 버튼 구분선
            
            Button {
                // 앞서 입력한 이메일과 비밀번호로 Firebase Auth에 계정을 생성하고 사용자 정보 문서(이메일, 닉네임)가 생성되어야 함.
                isShowSucceedToast.toggle()
                signUpWithEmailPassword()
                
            } label: {
                // 비동기 작업이 끝나기 전까지(작업 중)는 ProgressView를 띄워서 회원가입 버튼을 없앤다.
                if signUpViewModel.authenticationState == .authenticating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .frame(height: 40)
                } else { // 계정 생성 전이나 후에는 버튼을 띄운다.
                    RoundedRectangle(cornerRadius: 15)
                        .modifier(LoginButtonModifier(label: "회원가입"))
                }
            }
            // TextField가 비어있으면 "회원가입" 버튼 비활성화
            .disabled(nickName.isEmpty || nickName.count > 6 ? true : false)
        } // VStack
        .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
        .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
            endEditing()
        } // onTapGesture
        .toolbar {
            ToolbarItem(placement: .principal) { // 회원가입 진행 현황 툴바
                CustomProgressView(nowStep: 3)
            } // toolbarItem
        } // toolbar
        .popup(isPresented: $isShowSucceedToast, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                
                Text("회원가입이 성공적으로 완료되었습니다.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.accentColor)
            .cornerRadius(100)
        }) // Toast

    } // Body
}


struct SignUpStep2View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep2View(email: .constant(""), password: .constant(""), navStack: .constant(NavigationPath()))
    }
}
