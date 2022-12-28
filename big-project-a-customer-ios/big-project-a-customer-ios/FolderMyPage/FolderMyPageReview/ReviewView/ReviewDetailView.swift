//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI


// MARK: 각 항목들을 보여줄 하위 뷰인 CardView
struct ReviewDetailView: View {
    
    // 임시 리뷰 뷰 모델
    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    
    // 상위 뷰에서 리뷰 관련 데이터를 받아오는 프로퍼티
    var reviewDetail : MyReviewItems
    
    var body: some View {
        ZStack {
            VStack {
                
                //MARK: 리뷰 아이템의 상품명/옵션/카테고리/날짜를 보여주는 스택
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(reviewDetail.itemName)")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Text("\(reviewDetail.itemOption)")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text("\(reviewDetail.itemCategory)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(reviewDetail.purchaseDate)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 10)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                    }
                    .padding(.leading, 10)
                }
                .padding(.top, 5)
                
                
                //MARK: 리뷰 아이템의 별점을 보여주는 스택
                VStack(alignment: .leading) {
                    HStack (spacing: 2){
                        ForEach(0..<5){ i in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 13)
                                .foregroundColor(reviewDetail.stars > i ? .yellow : .gray)

                        }

                    }
                    .padding(.bottom, 5)
                    Text("\(reviewDetail.itemReview)")
                        .frame(width: 380, alignment: .leading)
                }
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                
                //MARK: 리뷰 아이템의 사진을 보여주는 이미지 슬라이더
                VStack{
                    ImageSlider(images: reviewDetail.itemImgs)
                        .frame(height: 300)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
     
            }
        }
    }
}


// MARK: - 이미지 슬라이더 뷰
struct ImageSlider: View {
    // 1. 이미지 배열 프로퍼티
    var images : [String]
    
    var body: some View {
        // 2 탭 뷰를 통한 이미지 여러 장 보여주기
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                 Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

//struct ReviewDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewDetailView()
//            .environmentObject(MyReviewViewModel())
//    }
//}



