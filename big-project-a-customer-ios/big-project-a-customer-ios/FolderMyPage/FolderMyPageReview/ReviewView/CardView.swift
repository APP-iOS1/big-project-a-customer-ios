//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct CardView: View {
    
    
    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    
    // MARK: - 상위 뷰에서 리뷰 관련 데이터를 받아오는 프로퍼티
    var card : MyReviewItems
    

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(card.itemName)")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Text("\(card.itemOption)")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text("\(card.itemCategory)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(card.purchaseDate)")
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
                                .foregroundColor(card.stars >= i ? .yellow : .gray)

                        }

                    }
                    .padding(.bottom, 5)
                    Text("\(card.itemReview)")
                        .frame(width: 380, alignment: .leading)
                    //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                }
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                VStack{

                    ImageSlider(images: card.itemImgs)
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

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//            .environmentObject(MyReviewViewModel())
//    }
//}
