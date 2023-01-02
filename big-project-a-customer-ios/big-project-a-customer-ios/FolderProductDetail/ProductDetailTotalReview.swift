//
//  ProductDetailTotalReview.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import SwiftUI

struct ProductDetailTotalReview: View {

    @EnvironmentObject var myReviewViewModel : MyReviewViewModel
    
    var body: some View {
        ScrollView {
            ForEach(myReviewViewModel.reviewItems) { review in
                ReviewDetail(review: review)
            }
        }
        .padding()
    }
}

struct ProductDetailTotalReview_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailTotalReview().environmentObject(MyReviewViewModel())
    }
}
