//
//  CouponView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI

struct Coupon: Identifiable {
    var id = UUID().uuidString
    var couponTitle: String
    var discountPercentage: Int
    var discountMaximumAmount: Int
    var couponDescription: String
    var minimumPurchase: Int
    var startDate: String
    var expiryDate: String
    var amountOfCoupons: Int
}

extension Coupon {
    static let coupons = [
        Coupon(couponTitle: "기본 할인", discountPercentage: 30, discountMaximumAmount: 99990, couponDescription: "★보뚜 위크 10%★", minimumPurchase: 1, startDate: "2022-12-27 10:24", expiryDate: "2022-12-31 23:59", amountOfCoupons: 1),
        Coupon(couponTitle: "기본 할인", discountPercentage: 10, discountMaximumAmount: 999990, couponDescription: "★오늘만★10% 상품쿠폰", minimumPurchase: 1, startDate: "2022-12-27 10:24", expiryDate: "2022-12-31 23:59", amountOfCoupons: 1),
        Coupon(couponTitle: "장바구니", discountPercentage: 30, discountMaximumAmount: 10000, couponDescription: "12월 30% 장바구니쿠폰", minimumPurchase: 1, startDate: "2022-12-28 10:24", expiryDate: "2022-12-28 23:59", amountOfCoupons: 1),
        Coupon(couponTitle: "장바구니", discountPercentage: 20, discountMaximumAmount: 15000, couponDescription: "12월 20% 장바구니 쿠폰 ", minimumPurchase: 1, startDate: "2022-12-27 10:24", expiryDate: "2022-12-31 23:59", amountOfCoupons: 1),
        Coupon(couponTitle: "장바구니", discountPercentage: 20, discountMaximumAmount: 99999990, couponDescription: "ASUS 단독 20%", minimumPurchase: 1, startDate: "2022-12-27 10:24", expiryDate: "2022-12-31 23:59", amountOfCoupons: 1)
    ]
}

// MARK: 전체 coupon 목록
struct CouponView: View {
    var body: some View {
        ScrollView {
            ForEach(Coupon.coupons) { coupon in
                CouponListCell(coupon: coupon)
                    .padding(.horizontal, 10)
            }
        }
    }
}

// MARK: 재사용하기 위한 coupon cell
struct CouponListCell: View{
    let coupon: Coupon
    var couponColor = Color.red
    
    var body: some View{
        ZStack{
            Image("couponBackgroundImage")
                .resizable()
                .frame(height: 180)
                .shadow(radius: 5)
            HStack{
                VStack(alignment: .leading){
                    Text("\(coupon.couponTitle)")
                        .foregroundColor(couponColor)
                        .bold()
                    HStack{
                        Text("\(coupon.discountPercentage)%")
                            .foregroundColor(couponColor)
                            .font(.title)
                            .bold()
                        Text("(최대 \(coupon.discountMaximumAmount)원 할인)")
                            .foregroundColor(couponColor)
                            .font(.callout)
                        
                    }
                    .padding(.bottom, 1)
                    Text("\(coupon.couponDescription)")
                        .padding(.vertical, 1)
                    Text("\(coupon.minimumPurchase)원 이상 구매시")
                        .modifier(TextCaptionGrayModifier())
                    Text("\(coupon.startDate) - \(coupon.expiryDate)")
                        .modifier(TextCaptionGrayModifier())
                }
                Spacer()
                Text("\(coupon.amountOfCoupons)장")
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
