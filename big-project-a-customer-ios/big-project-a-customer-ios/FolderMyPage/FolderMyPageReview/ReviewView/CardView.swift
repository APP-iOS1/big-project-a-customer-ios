//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    var card : MyReviewItems

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "iphone.gen1")
                            .font(.system(size: 50))
                            .foregroundColor(Color(.label))
                        
                        VStack(alignment: .leading) {
                            Text("\(card.itemName)")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Text("\(card.itemOption)")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text("\(card.itemCategory)")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(card.purchaseDate)")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        

                    }
                    .padding(10)
                }
                
                VStack(alignment: .leading) {
                    HStack (spacing: -1){
//                        Foreach(0..< card.stars){ i in
//                            Image(systemName: "star.fill")
//                                .foregroundColor(.yellow)
//                                .padding(0)
//                        }
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding(0)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding(0)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding(0)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding(0)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding(0)
                    }
                    .padding(.bottom, 5)
                    Text("\(card.itemReview)")
                        .frame(width: 350, alignment: .leading)
                    //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                }
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                //Divider()
                Rectangle()
                    .frame(width: 400)
                    .foregroundColor(.gray)
                    .opacity(0.20)
                    
            }
        }
        //.padding()
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//            .environmentObject(MyReviewViewModel())
//    }
//}
