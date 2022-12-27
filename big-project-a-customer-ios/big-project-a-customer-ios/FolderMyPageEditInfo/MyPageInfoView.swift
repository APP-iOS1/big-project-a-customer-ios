//
//  MyPageInfo.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

struct MyPageInfoView: View {
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var sampleActions = ["좋아요", "구매내역", "쿠폰함", "작성한 리뷰", "작성한 문의 글", "최근 본 상품"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("홍길동님")
                        .modifier(NameModifier())
                    Text("반갑습니다")
                        .modifier(SayHelloModifier())
                    Spacer()
                    NavigationLink {
                        MyPageInfoDetailView()
                    } label: {
                        Text("설정")
                    }
                }
                .padding(30)
                Text("혜택")
                    .modifier(GiftModifier())
               
                    
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(sampleActions, id: \.self) { action in
                        
                        // 더미 데이터들
                        ZStack {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                .cornerRadius(15)
                                .frame(width: 120, height: 100)
                                .padding()
                            NavigationLink {
                                Text(action)
                            } label: {
                                Text(action)
                                    .foregroundColor(.accentColor)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                List {
                    Label("주문목록", systemImage: "star")
                    Label("취소, 반품, 교환목록", systemImage: "star")
                    Label("리뷰관리", systemImage: "star")
                }
                .listStyle(.plain)
            }
            //        .padding()
        }
    }
    
}

struct MyPageInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoView()
    }
}
