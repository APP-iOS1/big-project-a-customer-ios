//
//  QnARow.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/03.
//

import SwiftUI
import Firebase

struct QnARow: View {
    
    @Binding var item: CustomerServiceInfo
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    // 첫번째 사진만 우선 나타나게 해줍니다
                    Image(systemName: "smiley.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
//                    Image(item.itemImage[0])
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.body)
                            .fontWeight(.medium)
                        
                        Text(item.itemName)
                            .font(.caption2)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        
                        HStack{
                            Text("카테고리 임시 값")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text(item.formattedServiceDate)
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    
                }

                .padding(.horizontal, 8)

            }
            
            VStack(alignment: .leading) {
                Text(item.description)

                    //정훈 주석 처리.frame(width: 350, alignment: .leading)

                //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                
                // QnA 답글이 아직 없는 경우 분류
                // FIXME: 답글의 길이가 길면 답글이 짤림. Rectangle의 height 유동적 조정 필요

                //                if item.answer != "" {
                //                    Rectangle()
                //                        .frame(width: UIScreen.main.bounds.width - 35, height: 200)
                //                        .foregroundColor(.gray)
                //                        .opacity(0.20)
                //                        .overlay(Text(item.answer)
                //                            .padding(),alignment: .topLeading)
                //                }
                
                // Rectangle의 height 유동적으로 변경
                // leading을 보장하기 위해 HStack + Spacer 활용
                // FIXME: - 답글 (DB에 아직 X)
//                if !item.answer.isEmpty {
//                    HStack {
//                        Text(item.answer)
//
//                        Spacer()
//                    }
//                    .padding()
//                    .overlay(
//                        Rectangle()
//                            .foregroundColor(.gray)
//                            .opacity(0.2)
//                    )
//                }
            }
            .frame(width: UIScreen.main.bounds.width - 35)
            
            //            Rectangle()
            //                .frame(width: 400)
            //                .foregroundColor(.gray)
            //                .opacity(0.20)
            

        }
    }
}

struct QnARow_Previews: PreviewProvider {
    static var previews: some View {
        QnARow(item: .constant(CustomerServiceInfo(id: "123-123-123", title: "배송 얼마나 걸리나요?", description: "현기증이 납니다", itemId: "klklasdjflaksd", itemName: "에어팟", itemImage: ["airpods"], serviceDate: .init(date: Date.now), customerId: "홍길동", orderId: "123123")))
    }
}
