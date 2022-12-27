//
//  MyPageInfoEditChecking.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

struct MyPageInfoEditChecking: View {
    
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
                Text(vm.users.userEmail)
            }
            
            HStack{
                Image(systemName: "key")
                SecureField("Password", text: $password)
            }

            
        }
        .padding()
        .alert("비밀번호 불일치", isPresented: $showingAlert) {
                    Button("Ok") {
                        password = ""
                    }
                } message: {
                    Text("비밀번호를 다시 입력해주세요")
                }
        if password == String(vm.users.userPassward) {
            NavigationLink {
                
                MyPageInfoEdit()
                
            } label: {
                Text("확인")
                    .modifier(ConfirmModifier())
                
            }
            //        .disabled(showingAlert)
            .simultaneousGesture(TapGesture().onEnded({
                password = ""
            }))
        } else {

            Button {
                showingAlert = true
            } label: {
                Text("확인")
                    .modifier(ConfirmModifier())
            }

        }
    }
}

struct MyPageInfoEditChecking_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageInfoEditChecking()
        }
    }
}
