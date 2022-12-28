//
//  MyPageInfoManagment.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI


// 마이페이지 -> 설정버튼 누르면 보이는 내 정보 뷰

struct MyPageInfoDetailView: View {
    
    @StateObject var vm = MyPageViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // 프로필 사진 기능 추가 예정
                Image(systemName: "person")
                    .modifier(ProfileModifier())
              
                // 유저 이름
                Text(vm.users.name)
                    .modifier(NameModifier())
                
                Spacer()
                
                //데이터 연결 후 로그아웃 로직 연결될 버튼
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
                        // 유저 이름
                        Text(vm.users.name)
                        Spacer()
                        
                        // 회원정보 수정 링크
                        // 비밀번호, 주소를 수정할 수 있음
                        NavigationLink {
                            MyPageInfoEditCheckingView()
                        } label: {
                            Text("회원정보 수정")
                        }
                    }
                    // 유저 이메일
                    Text(vm.users.userEmail)
                    // 유저 전화번호
                    Text(vm.users.phoneNumber)
                    // 유저 주소
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


