//
//  MyPageInfoManagment.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI
import PhotosUI

// 마이페이지 -> 설정버튼 누르면 보이는 내 정보 뷰

struct MyPageInfoDetailView: View {
    
    @StateObject var vm = MyPageViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
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
            
            HStack {
                
                Text("회원정보")
                    .font(.title3)
                
                // 회원정보 수정 링크
                // 비밀번호, 주소를 수정할 수 있음
                
                Spacer()
                
                NavigationLink {
                    MyPageInfoEditCheckingView()
                } label: {
                    Text("회원정보 수정")
                }
            }
            .padding(.horizontal, 30)
            
            Divider()
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 20) {
                    
                    Text("고객명")
                        .foregroundColor(.secondary)
                    
                    Text("홍길동")
                    
                    Spacer()
                    
                    
                }
                
                HStack(alignment: .top, spacing: 20) {
                    Text("이메일")
                        .foregroundColor(.secondary)
                    Text("yahoth@naver.com")
                }
                
                HStack(alignment: .top, spacing: 20) {
                    Text("연락처")
                        .foregroundColor(.secondary)
                    Text("010-1234-1234")
                    
                }
                HStack(alignment: .top, spacing: 34.5) {
                    Text("주소")
                        .foregroundColor(.secondary)
                    Text("서울특별시 A대로 100번지")
                }
                
            }
            .padding(30)
            
            Divider()
            
            
            
            Spacer()
        }
        .navigationTitle("내정보관리")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct MyPageInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageInfoDetailView()
        }
    }
}


