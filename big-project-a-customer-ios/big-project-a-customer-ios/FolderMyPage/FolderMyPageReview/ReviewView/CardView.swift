//
//  CardView.swift
//  Review
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct CardView: View {

    // MARK: - 상위 뷰에서 리뷰 관련 데이터를 받아오는 프로퍼티
    var item : MyReviewItems
    
    var body: some View {
        NavigationLink(destination: Text("\(item.stars)")) {
            
            Text(item.itemName)
            
            
        }
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//            .environmentObject(MyReviewViewModel())
//    }
//}
