//
//  ReviewDetail.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import SwiftUI

struct ReviewDetail: View {
    
    
    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    
    // MARK: - 상위 뷰에서 리뷰 관련 데이터를 받아오는 프로퍼티
    var review : MyReviewItems

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        
                        Image(systemName: review.profileImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text("\(review.id)")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Text("\(review.itemName) \(review.itemOption)")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text("\(review.itemCategory)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(review.purchaseDate)")
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
                
                VStack(alignment: .leading) {
                    HStack (spacing: 2){
                        ForEach(0..<5){ i in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 13)
                                .foregroundColor(review.stars > i ? .yellow : .gray)

                        }

                    }
                    .padding(.bottom, 5)
                    Text("\(review.itemReview)")
                        .frame(width: 380, alignment: .leading)
                    //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                }
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                VStack{

                    DetailImageSlider(images: review.itemImgs)
                        .frame(height: 300)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                //Divider()
                Rectangle()
                    .frame(width: 400)
                    .foregroundColor(.gray)
                    .opacity(0.20)
                    
            }

        }
    }
}

// MARK: - 이미지 슬라이더 뷰
struct DetailImageSlider: View {
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

struct ReviewDetail_Previews: PreviewProvider {
    static var previews: some View {
       ReviewDetail(review: MyReviewItems(id: "침착맨", profileImage: "person.circle.fill", date: "2023-01-01", itemName: "MacBook Air 13", itemOption: "SSD 512gb", itemCategory: "노트북", purchaseDate: "2022-12-24", itemReview: "맥북 에어를 샀는데 맥북 프로가 왔네요 오히려 좋아", itemImgs: ["macbookpro1", "macbookpro2"], stars: 5))
    }
}
