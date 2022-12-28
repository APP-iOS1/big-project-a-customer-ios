//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct QuestionDetailView: View {
    @Binding var item: QuestionItems
    @ObservedObject var vm: QuestionViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.body)
                            .fontWeight(.medium)
                        
                        Text(item.itemName)
                            .font(.caption2)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        
                        HStack{
                            Text(item.itemCategory)
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text(item.date)
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
                
                Text(item.question)
                    .frame(width: 350, alignment: .leading)
                //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                
                // QnA 답글이 아직 없는 경우 분류
                // FIXME: 답글의 길이가 길면 답글이 짤림. Rectangle의 height 유동적 조정 필요
                if item.answer != "" {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 35, height: 200)
                        .foregroundColor(.gray)
                        .opacity(0.20)
                        .overlay(Text(item.answer)
                            .padding(),alignment: .topLeading)
                }
            }
            .frame(width: 360, alignment: .leading)
            .padding()
            
//            Rectangle()
//                .frame(width: 400)
//                .foregroundColor(.gray)
//                .opacity(0.20)
            
        }
    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    @State static var items = QuestionItems(title: "애케플 문의 드립니다.", question: "스페이스 그레이를 샀습니다 살 때 애케플 까먹고 구매 안했는데 15%할인된 가격으로 추가 구매 할 수 있는 방법 있을 가요?", answer: "Apple 2021 맥북프로 14 상품은 구매 후 상품페이지를 통해 AppleCare+만 단독 구매가 가능하지 않으며, 애플케어 관련 문의는 애플공식서비스센터/ 080-000-0000 또는 애플 홈페이지를 통해 자세한 상담이 가능한 점 참고하여 이용 부탁드립니다.", itemName: "iPhone14 Pro", itemCategory: "스마트폰", date: "2022-11-21", image: "Phone")
    @StateObject static var vm = QuestionViewModel()
    
    static var previews: some View {
        QuestionDetailView(item: $items, vm: vm)
    }
}
