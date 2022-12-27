//
//  PurchaseHistoryView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI

struct PurchaseHistoryView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10){ _ in
                PurchaseListCell()
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct PurchaseListCell: View{
    @State var orderDate = "2022. 12. 21"
    @State var itemAmount = 1
    @State var price = 29400
    @State var deliveryStatus = "배송완료"
    @State var itemName = "ipTIME 외장케이스 WHITE HDD 3135 Plus"
    @State var itemImage = "itemImage" // image
    
    var strokeColor = Color.gray
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(deliveryStatus)")
                    .font(.headline)
            }
            HStack(alignment: .top){
                Image(itemImage)
                    .resizable()
                    .frame(width: 80,height: 80)
                VStack(spacing: 20){
                    Text("\(itemName)")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                    HStack{
                        Text("\(price)원")
                            .font(.caption)
                        Text("\(itemAmount)개")
                            .font(.caption)
                        Spacer()
                        Button {
                            // 장바구니로 이동
                        } label: {
                            Text("장바구니 담기")
                                .font(.caption)
                        }

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack{
                Button {
                    // 교환 반품 신청
                } label: {
                    Text("교환, 반품 신청")
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(strokeColor, lineWidth: 1)
                )
                Button {
                    // 배송 조회
                } label: {
                    Text("배송 조회")
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(strokeColor, lineWidth: 1)
                )
            }
            .font(.callout)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .overlay(
               RoundedRectangle(cornerRadius: 10)
                   .stroke(strokeColor, lineWidth: 1)
        )
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseHistoryView()
    }
}
