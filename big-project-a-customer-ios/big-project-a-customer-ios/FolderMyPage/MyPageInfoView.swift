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
    
    @EnvironmentObject private var signupViewModel: SignUpViewModel
    //    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State var loginSheetShowing: Bool = false
    @State var loginAlertShowing: Bool = false
    
    //더미 데이터
    var sampleActions = ["좋아요", "구매내역", "작성한 리뷰", "고객센터", "최근 본 상품", "취소, 반품, 교환목록"]
    var sampleIcons = ["heart.fill", "doc.richtext", "person.fill.questionmark", "clock.badge.checkmark", "tray.full.fill", "arrow.uturn.backward.square"]
    var sampleMenu = ["취소, 반품, 교환목록"]
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                // 로그인 상태일 때 보이는 뷰
                if signupViewModel.loginRequestState == .loggedIn {
                    HStack(alignment: .bottom) {
                        // 유저 이름
                        Text("\(signupViewModel.currentUser?.userNickname ?? "")님")
                            .modifier(NameModifier())
                        Text("반갑습니다")
                            .modifier(SayHelloModifier())
                        Spacer()
                        NavigationLink {
                            MyPageInfoDetailView()
                        } label: {
                            // 내 정보 관리로 이어지는 링크
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    
                } else {
                    // 로그인 상태가 아닐 때 보이는 뷰
                    HStack {
                        // 유저 이름
                        Text("로그인이 필요합니다")
                            .modifier(NameModifier())
                        Spacer()
                        Button {
                            loginSheetShowing.toggle()
                        } label: {
                            // 내 정보 관리로 이어지는 링크
                            Text("로그인")
                        }
                    }
//                    .padding(20)
                }
                // 좋아요, 구매내역, 쿠폰함 등 이후 다른 뷰들과 연결될 그리드
                LazyVGrid(columns: columns, spacing: 19) {
                    ForEach(Array(sampleActions.enumerated()), id: \.offset) { (idx, action) in
                        if signupViewModel.loginRequestState == .notLoggedIn {
                            Button {
                                loginAlertShowing.toggle()
                            } label: {
                                MyPageCell(imageName: sampleIcons[idx], text: action)
                            }
                        } else {
                            NavigationLink(value: action) {
                                MyPageCell(imageName: sampleIcons[idx], text: action)
                            }
                            .navigationDestination(for: String.self) { action in
                                switch action {
                                case "좋아요":
                                    LikedProductsView()
                                case "구매내역":
                                    PurchaseHistoryView()
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
                            }
                        }
                    }
                }
                .alert("로그인이 필요해요", isPresented: $loginAlertShowing) {
                    Button("취소", role: .cancel) {
                    }
                    Button("로그인") {
                        loginAlertShowing.toggle()
                        loginSheetShowing.toggle()
                    }
                }
                .fullScreenCover(isPresented: $loginSheetShowing) {
                    LoginView()
                }
            }
            .padding(20)
            .navigationTitle("마이페이지")
            Spacer()
        }
        
    }
}

struct MyPageCell: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                Image(systemName: imageName)
                Text(text)
            }
            .foregroundColor(.accentColor)
            .fontWeight(.bold)
            .modifier(TmpButtonModifier(color: .white))
        }
    }
}

struct MyPageInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoView()
            .environmentObject(MyReviewViewModel())
            .environmentObject(SignUpViewModel())
    }
}

