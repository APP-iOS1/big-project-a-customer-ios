//
//  MyPageInfoManagment.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

struct MyPageInfoDetailView: View {
    @StateObject var vm = MyPageViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .modifier(ProfileModifier())
              
                Text(vm.users.name)
                    .modifier(NameModifier())
                
                Spacer()
                
                Button {
                    print("로그아웃")
                } label: {
                    Text("로그아웃")
                }
                
            }
            .padding(30)
            
            Text("회원정보")
                .padding(.leading, 30)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("고객명")
                    Text("이메일")
                    Text("연락처")
                    Text("주소")
                    
                }
                //.foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    HStack {
                        Text(vm.users.name)
                        Spacer()
                        NavigationLink {
                            MyPageInfoEditCheckingView()
                        } label: {
                            Text("회원정보 수정")
                        }
                    }
                    
                    Text(vm.users.userEmail)
                    Text(vm.users.phoneNumber)
                    Text(vm.users.userAddress)

                }
            }
            .padding(.horizontal, 30)
            Divider()
  
        }
    }
}


struct MyPageInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageInfoDetailView()
        }
    }
}





//            .padding(.horizontal, 30)
            //            List {
            //                Label("와우 멤버쉽", systemImage: "star")
            //                Label("브랜드 멤버쉽 관리", systemImage: "star")
            //                Label("푸시설정", systemImage: "star")
            //            }
            //            .listStyle(.plain)
            //
          
