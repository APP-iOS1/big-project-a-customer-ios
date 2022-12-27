//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct QuestionDetailView: View {

    var body: some View {
            //        ZStack {
            VStack {
                VStack {
                    HStack {
                        //                        Image(systemName: "iphone.gen1")
                        //                            .font(.system(size: 50))
                        //                            .foregroundColor(Color(.label))
                        
                        VStack(alignment: .leading) {
                            Text("문의 제목")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Text("상품명")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            HStack{
                                Text("카테고리")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("문의 날짜")
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
                    
                    Text("상세 문의 내용...")
                        .frame(width: 350, alignment: .leading)
                    //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                }
                .frame(width: 360, alignment: .leading)
                .padding()
                
                Rectangle()
                    .frame(width: 400)
                    .foregroundColor(.gray)
                    .opacity(0.20)
                //Divider()
                
            }
//        }
    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetailView()
    }
}
