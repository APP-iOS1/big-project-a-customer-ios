//
//  MyQuestionView.swift
//  Review
//
//  Created by 기태욱 on 2022/12/27.
//

import SwiftUI

// MARK: - 작성한 문의 글 데이터 모델 (목업)
// FIXME: 데이터 변경 필요함!
struct QuestionItems: Identifiable {
    var id = UUID().uuidString
    var title: String
    var question: String
    var answer: String
    var itemName: String
    var itemCategory: String
    var date: String
    var image: String
}

// MARK: - 작성한 문의 글 뷰 모델
// FIXME: 데이터 변경 필요함!
/// 최근 본 상품  item들을 가지고 있음
class QuestionViewModel: ObservableObject {
    @Published var questionItems: [QuestionItems] = [
        QuestionItems(title: "재입고 날짜 문의 드립니다.", question: "빨리 사고 싶은데 언제쯤 입고되나요?? 정확한 날짜를 알 수 있을까요?", answer: "", itemName: "MacBook Air M1", itemCategory: "노트북", date: "2022-11-26", image: "Notebook"),
        QuestionItems(title: "애케플 문의 드립니다.", question: "스페이스 그레이를 샀습니다 살 때 애케플 까먹고 구매 안했는데 15%할인된 가격으로 추가 구매 할 수 있는 방법 있을 가요?", answer: "Apple 2021 맥북프로 14 상품은 구매 후 상품페이지를 통해 AppleCare+만 단독 구매가 가능하지 않으며, 애플케어 관련 문의는 애플공식서비스센터/ 080-000-0000 또는 애플 홈페이지를 통해 자세한 상담이 가능한 점 참고하여 이용 부탁드립니다.", itemName: "iPhone14 Pro", itemCategory: "스마트폰", date: "2022-11-21", image: "Phone"),
        QuestionItems(title: "화면 크기 상세사항 문의 드립니다.", question: "A4용지에 비해 어느 정도 크기인지 가늠이 안됩니다. 가로 세로 상세 크기를 알 수 있을까요?", answer: "네 알려드렸습니다~", itemName: "iPad Pro 12.9", itemCategory: "태블릿", date: "2022-12-28", image: "Tablet")
    ]
}

struct MyQuestionReview: View {
    @ObservedObject var questionViewModel: QuestionViewModel = QuestionViewModel()
    @State var isShowingDuration : Bool = false
    
    var body: some View {

        VStack{
            HStack{
                Text("전체")
                Text("1개월")
                
                Spacer()
                
                Button{
                    isShowingDuration.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            .padding()
            
            ZStack{
                
                DurationSettingView(isShowingDuration : $isShowingDuration)
                    .opacity(isShowingDuration ? 1 : 0)
                    .zIndex(1)
                
                ScrollView(showsIndicators: false, content: {
                    ForEach($questionViewModel.questionItems) { item in
                        QuestionDetailView(item: item, vm: questionViewModel)
                        .padding(.vertical)

                        Divider()
                    }
                    
                    // 스크롤 아래 빈공간 네모
                    Rectangle()
                        .frame(height: 300)
                        .foregroundColor(.clear)
                })
                .navigationTitle("작성한 문의 글")
                
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)

    }
}

struct MyQuestionReview_Previews: PreviewProvider {
    static var previews: some View {
        MyQuestionReview()
    }
}
