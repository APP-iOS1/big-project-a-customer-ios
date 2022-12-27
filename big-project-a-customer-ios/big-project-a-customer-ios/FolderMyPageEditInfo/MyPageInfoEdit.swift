//
//  MyPageInfoEdit.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

struct MyPageInfoEdit: View {
    
    @State var newPassword = ""
    @State var checkPassword = ""
    
    @State var newAddress = ""
    
    
    var body: some View{
        VStack{
            Text("비밀 번호 수정")
                .font(.title)
            
            SecureField("Input new password.", text: $newPassword)
                .modifier(InputModifier())
               
            SecureField("One more time.", text: $checkPassword)
                .modifier(InputModifier())
          
            
            Button {
                print("변경")
            } label: {
                Text("비밀번호 변경")
                    .modifier(ConfirmModifier())
            }
            .padding(.bottom,20)
            
            
            Text("주소 변경하기")
                .font(.title)
            
            TextField("New Address", text: $newAddress)
                .modifier(InputModifier())
            
            Button {
                print("변경")
            } label: {
                Text("주소 변경")
                    .modifier(ConfirmModifier())
            }

        }
    }
}

struct MyPageInfoEdit_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoEdit()
    }
}
