//
//  MyPageInfoEdit.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

// 비밀번호 체크 후 나오는 정보를 수정할 수 있는 뷰

struct MyPageInfoEditView: View {
    @StateObject var vm = MyPageViewModel()
    
    @State var newPassword = ""
    @State var checkPassword = ""
    
    @State var newAddress = ""
    
    @State var showingAlert = false
    
    var body: some View{
        VStack{
            
            //MARK: - 비밀번호를 변경하는 부분

            Text("비밀 번호 수정")
                .font(.title)
            // 수정할 비밀번호를 입력하는 텍스트필드
            SecureField("Input new password.", text: $newPassword)
                .modifier(InputModifier())
            // 수정할 비밀번호를 한 번 더 확인하는 텍스트필드
            SecureField("One more time.", text: $checkPassword)
                .modifier(InputModifier())
            
            
            Button {
                
                /// 비밀번호가 공백이거나, 엔터가 눌린 상태에서 변경 버튼이 눌리지 않게끔하는 조건을 걸고
                /// 그 안에 두 번 입력한 비밀번호가 같을 경우 비밀번호 변경을 시행 가능하게 함
                if newPassword.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    // 비밀번호가 같을 때 비밀번호 변경할 수 있는 조건
                    if newPassword == checkPassword {
                        // 새로 입력한 비밀번호를 저장
                        vm.users.userPassward = newPassword
                    } else {
                        // 입력한 두 비밀번호가 다를 때 alert를 띄워서
                        // 일치하지 않다는 것을 알림
                        showingAlert = true
                    }
                }
                
            } label: {
                Text("비밀번호 변경")
                    .modifier(ConfirmModifier())
            }
            .padding(.bottom,20)
            // alert: 입력한 두 비밀번호가 일치하지 않을 때 알림
            // ok버튼을 누르면 텍스트필드 초기화
            .modifier(PasswordAlertModifier(showingAlert: $showingAlert, password: $newPassword, password_2: $checkPassword))

            //MARK: - 주소를 변경하는 부분
            Text("주소 변경하기")
                .font(.title)
            
            TextField("New Address", text: $newAddress)
                .modifier(InputModifier())
            
            // 주소 변경 버튼
            Button {
                // 입력한 텍스트가 띄어쓰기나, 엔터 버튼이 눌렸을 때 버튼이 작동되지 않는 조건
                if newAddress.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    // 새로 입력한 주소를 저장
                    vm.users.userAddress = newAddress
                }
            } label: {
                Text("주소 변경")
                    .modifier(ConfirmModifier())
            }
        }
    }
}

struct MyPageInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoEditView()
    }
}
