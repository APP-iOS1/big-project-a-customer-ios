//
//  MyReview.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct MyReview: View {
    
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
                    
                    
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                })
                .navigationTitle("작성한 리뷰")
                //.opacity(isShowingDuration ? 0.2 : 1)
                //        .toolbar {
                //            Button {
                //
                //            } label: {
                //                Image(systemName: "house")
                //            }
                //
                //        }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}


struct MyReview_Previews: PreviewProvider {
    static var previews: some View {
        MyReview()
    }
}
