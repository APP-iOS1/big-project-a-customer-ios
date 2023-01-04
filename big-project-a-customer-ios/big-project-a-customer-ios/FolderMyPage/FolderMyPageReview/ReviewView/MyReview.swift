//
//  MyReview.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

// MARK: - 임시 리뷰 데이터 모델
//struct MyReviewItems: Identifiable {
//    var id = UUID().uuidString
//    var date: String
//    var writer: String
//    var witerId: String
//    var orderNumber: String
//    var itemId: Int
//    var reviewText: Int
//    var stars: Int
//    var itemImg: String
//}


// MARK: - 목업용 리뷰 데이터 모델
struct MyReviewItems: Identifiable {
    var id: String
    var profileImage: String
    var date: String
    var itemName: String
    var itemOption: String
    var itemCategory: String
    var purchaseDate: String
    var itemReview: String
    var itemImgs: [String]
    var stars: Int
}


// MARK: - 임시 리뷰 뷰 모델
/// 내 리뷰 항목에 담긴 item들을 가지고 있음
class MyReviewViewModel: ObservableObject {
    // MyReviewItems 약자
    @Published var mRItems: [MyReviewItems] = [
        MyReviewItems(id: "홍길동", profileImage: "person.fill", date: "2022-12-07", itemName: "MacBook Air M1", itemOption: "SSD 256gb", itemCategory: "노트북", purchaseDate: "2022-11-30", itemReview: "가벼워서 카페에 들고다니기 좋아요!", itemImgs: ["macbookair1", "macbookair2", "macbookair3"], stars: 4),
        MyReviewItems(id: "홍길동", profileImage: "person.fill", date: "2022-12-02", itemName: "MacBook Pro 16", itemOption: "Space Black", itemCategory: "노트북", purchaseDate: "2022-11-26", itemReview: "화면이 커서 시원시원합니다, 조금 무거운게 단점이에요", itemImgs: ["macbookpro1", "macbookpro2"], stars: 4),
        MyReviewItems(id: "홍길동", profileImage: "person.fill", date: "2022-11-17", itemName: "iPhone14 Pro", itemOption: "256gb", itemCategory: "핸드폰", purchaseDate: "2022-10-29", itemReview: "카메라 성능이 너무 좋습니다, 다이나믹 아일랜드 영롱해요", itemImgs: ["iphone14pro1", "iphone14pro2"], stars: 5)
    ]
    
    @Published var reviewItems: [MyReviewItems] = [
        MyReviewItems(id: "둘리", profileImage: "person.fill", date: "2023-01-02", itemName: "MacBook Air 13", itemOption: "SSD 256gb", itemCategory: "노트북", purchaseDate: "2022-12-25", itemReview: "호이 호이", itemImgs: ["macbookair1", "macbookair2", "macbookair3"], stars: 4),
        MyReviewItems(id: "침착맨", profileImage: "person.fill", date: "2023-01-01", itemName: "MacBook Air 13", itemOption: "SSD 512gb", itemCategory: "노트북", purchaseDate: "2022-12-24", itemReview: "맥북 에어를 샀는데 맥북 프로가 왔네요 오히려 좋아", itemImgs: ["macbookpro1", "macbookpro2"], stars: 5)
        
    ]
}


struct MyReview: View {
    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    
    @State var isShowingDuration : Bool = false
    
    var tests = [1,2,3]
    
    var body: some View {
        VStack{
            //            HStack{
            //                Text("전체")
            //                Text("1개월")
            //
            //                Spacer()
            //
            //                Button{
            //                    isShowingDuration.toggle()
            //                } label: {
            //                    Image(systemName: "slider.horizontal.3")
            //                }
            //            }
            //            .padding()
            //
            //            ZStack{
            //                DurationSettingView(isShowingDuration : $isShowingDuration)
            //                    .opacity(isShowingDuration ? 1 : 0)
            //                    .zIndex(1)
            
            NavigationView {
                List {
                    ForEach(myReviewViewModel.mRItems, id: \.itemName) { mRItem in
                        CardView(item: mRItem)
                        //                            Text("\(mRItem.itemName)")
                    }
                    
                    
                    //                NavigationView {
                    //
                    //                    ScrollView(showsIndicators: false, content: {
                    //                        ForEach(myReviewViewModel.mRItems) { mRItem in
                    //                            CardView(item: mRItem)
                    //
                    //                            Divider()
                    //                        }
                    //
                    //
                    //
                    //                    })
                    //                }
                    
                    
                    
                }
                .listStyle(.inset)
            }
            .navigationTitle("작성한 리뷰")
            .navigationBarTitleDisplayMode(.large)
            
            
        }
    }
}

struct MyReview_Previews: PreviewProvider {
    static var previews: some View {
        MyReview()
    }
}
