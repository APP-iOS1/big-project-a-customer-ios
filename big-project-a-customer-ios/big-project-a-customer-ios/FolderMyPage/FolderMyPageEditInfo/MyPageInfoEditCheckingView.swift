//
//  MyPageInfoEditChecking.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

//회원정보 수정을 누르면 보이는 -> 비밀번호 체크 뷰

struct MyPageInfoEditCheckingView: View {
    
    @StateObject var vm = MyPageViewModel()
    
    @State var showingAlert = false
    @State var password = ""
    
    
    var body: some View {
        
        VStack(alignment:.leading){
            Text("회원정보확인")
                .bold()
            Text("정보를 안전하게 보호하기 위해 다시 한번 입력해주세요.")
            
            Divider()
            
            HStack{
                Image(systemName: "mail")
                // 유저 이메일
                Text(vm.users.userEmail)
            }
            
            HStack{
                Image(systemName: "key")
                SecureField("Password", text: $password)
            }
            
            
        }
        .padding()
        // 비밀번호 체크 후 일치하지 않을 시 나오는 alert
//        .alert("비밀번호 불일치", isPresented: $showingAlert) {
//            Button("Ok") {
//                password = ""
//            }
//        } message: {
//            Text("비밀번호를 다시 입력해주세요")
//        }
        .modifier(PasswordAlertModifier(showingAlert: $showingAlert, password: $password, password_2: $password))
        
        // 입력한 비밀번호가 일치할 시 네비게이션 링크를 보여주고,
        // 불일치할 시 버튼을 보여주고, alert를 띄운다
        if password == String(vm.users.userPassward) {
            NavigationLink {
                
                MyPageInfoEditView()
                
            } label: {
                Text("확인")
                    .modifier(ConfirmModifier())
                
            }
            // 링크 클릭 후 입력받은 textField 초기화
            .simultaneousGesture(TapGesture().onEnded({
                password = ""
            }))
        } else {
            
            // 비밀번호가 불일치 시 보여주는 버튼
            // 클릭하면 alert이 뜬다
            // navigationLink와 외관상 차이점 없음
            Button {
                showingAlert = true
            } label: {
                Text("확인")
                    .modifier(ConfirmModifier())
            }
            
        }
    }
}

struct MyPageInfoEditCheckingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageInfoEditCheckingView()
        }
    }
}
