//
//  MyPageInfoEditChecking.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

struct MyPageInfoEditChecking: View {
    
    
    @State var password = ""
    
    
    var body: some View {
       
        VStack(alignment:.leading){
            Text("회원정보확인")
                .bold()
            Text("정보를 안전하게 보호하기 위해 다시 한번 입력해주세요.")
            
            Divider()
                
            HStack{
                Image(systemName: "mail")
                Text("testEmail@gmail.com")
            }
            
            HStack{
                Image(systemName: "key")
                SecureField("Password", text: $password)
            }

            
        }
        
        NavigationLink {
            MyPageInfoEdit()
        } label: {
            Text("확인")
                .modifier(ConfirmModifier())
        }
    
    }
}

struct MyPageInfoEditChecking_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoEditChecking()
    }
}
