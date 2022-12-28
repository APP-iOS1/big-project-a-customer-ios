//
//  MyQuestionView.swift
//  Review
//
//  Created by 기태욱 on 2022/12/27.
//

import SwiftUI

struct MyQuestionReview: View {
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
                    
                    QuestionDetailView()
                    QuestionDetailView()
                    QuestionDetailView()
                    QuestionDetailView()
                })
                .navigationTitle("작성한 문의 글")
                
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)

    }
}

struct MyQuestionReview_Previews: PreviewProvider {
    static var previews: some View {
        MyReview()
    }
}

//struct DesignView: View {
//
//    @State var name: String
//    @State var age: Int
//    @State var gender: String
//
//    var body: some View {
//        ZStack(alignment: .leading){
//            RoundedRectangle(cornerRadius: 10.0)
//                .fill(Color.blue)
//                .frame(height: 100)
//            VStack(alignment: .leading){
//                Text(name)
//                    .foregroundColor(.white)
//                    .font(.title)
//                Text("\(age)")
//                    .foregroundColor(.white)
//                    .font(.title2)
//                Text(gender)
//                    .foregroundColor(.white)
//                    .font(.title2)
//            }
//            .padding()
//        }
//        .padding()
//    }
//}
//
//struct Data: Identifiable {
//    let id = UUID()
//    var name: String
//    var age: Int
//    var gender: String
//}
