//
//  CouponView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI

// MARK: 전체 coupon 목록
struct CouponView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10) { _ in
                CouponListCell()
                    .padding(.horizontal, 10)
            }
        }
    }
}

// MARK: 재사용하기 위한 coupon cell
struct CouponListCell: View{
    @State var couponTitle = "기본 할인"
    @State var discountPercentage = 30
    @State var discountMaximumAmount = 99990
    @State var couponDescription = "★보뚜 위크 10%★"
    @State var minimumPurchase = 1
    @State var startDate = "2022-12-27 10:24"
    @State var expiryDate = "2022-12-31 23:59"
    @State var amountOfCoupons = 1
    
    var couponColor = Color.red
    var body: some View{
        ZStack{
            Image("couponBackgroundImage")
                .resizable()
                .frame(width: .infinity, height: 180)
                .shadow(radius: 5)
            HStack{
                VStack(alignment: .leading){
                    Text("\(couponTitle)")
                        .foregroundColor(couponColor)
                        .bold()
                    HStack{
                        Text("\(discountPercentage)%")
                            .foregroundColor(couponColor)
                            .font(.title)
                            .bold()
                        Text("(최대 \(discountMaximumAmount)원 할인)")
                            .foregroundColor(couponColor)
                            .font(.callout)
                        
                    }
                    .padding(.bottom, 1)
                    Text("\(couponDescription)")
                        .padding(.vertical, 1)
                    Text("\(minimumPurchase)원 이상 구매시")
                        .modifier(TextCaptionGrayModifier())
                    Text("\(startDate) - \(expiryDate)")
                        .modifier(TextCaptionGrayModifier())
                }
                Spacer()
                Text("\(amountOfCoupons)장")
                    .padding(.trailing, 5)
            }
            .padding(.leading, 15)
            .padding(15)
        }
    }
}

struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        CouponView()
    }
}
