//
//  MyPageInfo.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI
import FirebaseAuth
// 마이페이지 탭을 누르면 보이는 -> 마이페이지가 시작되는 뷰

struct MyPageInfoView: View {
    
    @StateObject var vm = MyPageViewModel()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    //더미 데이터
    var sampleActions = ["좋아요", "구매내역", "작성한 리뷰", "고객센터", "최근 본 상품", "취소, 반품, 교환목록"]
    
    var sampleMenu = ["취소, 반품, 교환목록"]
    
    var body: some View {
        NavigationStack {
            
            VStack {
                // 로그인 상태일 때 보이는 뷰
//                if Auth.auth().currentUser != nil {
                    HStack {
                        // 유저 이름
                        Text(vm.users.name)
                            .modifier(NameModifier())
                        Text("반갑습니다")
                            .modifier(SayHelloModifier())
                        Spacer()
                        NavigationLink {
                            MyPageInfoDetailView()
                        } label: {
                            // 내 정보 관리로 이어지는 링크
                            Text("설정")
                        }
                    }
                    .padding(30)
//                } else {
//                    // 로그인 상태가 아닐 때 보이는 뷰
//                    HStack {
//                        // 유저 이름
//                        Text("로그인이 필요합니다")
//                            .modifier(NameModifier())
//                        Spacer()
//                        NavigationLink {
//                            MyPageInfoDetailView()
//                        } label: {
//                            // 내 정보 관리로 이어지는 링크
//                            Text("설정")
//                        }
//                    }
//                    .padding(30)
//                }
                
                // 혜택 이미지
                Image("event")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .modifier(GiftModifier())
                
                
                // 좋아요, 구매내역, 쿠폰함 등 이후 다른 뷰들과 연결될 그리드
                LazyVGrid(columns: columns, spacing: 0) {
                    //뷰들과 연결되면 ForEach문은 없앨 예정
                    ForEach(sampleActions, id: \.self) { action in
                        // 더미 데이터들
                        NavigationLink {
                            switch action {
                            case "좋아요":
                                LikedProductsView()
                            case "구매내역":
                                PurchaseHistoryView()
                                //                            case "쿠폰함":
                                //                                CouponView()
                            case "작성한 리뷰":
                                MyReview()
                            case "고객센터":
                                MyPageCustomerServiceView()
                            case "최근 본 상품":
                                MyRecentView()
                            case "취소, 반품, 교환목록":
                                EmptyView()
                            default :
                                Text("default")
                            }
                            
                        } label: {
                            
                            ZStack {
                                Color(.systemMint)
                                    .cornerRadius(15)
                                    .frame(width: 120, height: 100)
                                    .padding(5)
                                VStack {
                                    switch action {
                                    case "좋아요":
                                        Image(systemName: "hand.thumbsup")
                                    case "구매내역":
                                        Image(systemName: "ticket")
                                        //                                    case "쿠폰함":
                                        //                                        Image(systemName: "ticket")
                                    case "작성한 리뷰":
                                        Image(systemName: "doc.text")
                                    case "고객센터":
                                        Image(systemName: "doc.text")
                                    case "최근 본 상품":
                                        Image(systemName: "doc.text")
                                    case "취소, 반품, 교환목록":
                                        Image(systemName: "doc.text")
                                    default :
                                        Image(systemName: "doc.text")
                                    }
                                    Text(action)
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.black)
                                
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                //목업 상태
                Spacer()
                //                List {
                //                    ForEach(sampleMenu, id: \.self) { menu in
                //                        NavigationLink {
                //                            EmptyView()
                //
                //                        } label: {
                //                            Text(menu)
                //                        }
                //
                //                    }
                //                }
                //                .listStyle(.plain)
            }
        }
    }
    
}



struct MyPageInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoView()
            .environmentObject(MyPageViewModel())
            .environmentObject(MyReviewViewModel())
    }
}

