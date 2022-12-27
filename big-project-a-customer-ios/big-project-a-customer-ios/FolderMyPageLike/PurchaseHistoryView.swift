//
//  PurchaseHistoryView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI

// MARK: 전체 구매목록
struct PurchaseHistoryView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<10){ _ in
                    VStack {
                        HStack {
                            Text("2022.12.3")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                            Button {
                                // 주문 상세보기
                            } label: {
                                Text("주문 상세보기")
                                Image(systemName: "chevron.right")
                            }
                            
                        }
                        
                        PurchaseListCell()
                    }
                    .padding(10)
                }
            }
        }
    }
}

// MARK: 재사용하기 위한 구매목록 cell
struct PurchaseListCell: View {
    @State var orderDate = "2022. 12. 21"
    @State var itemAmount = 1
    @State var price = 29400
    @State var deliveryStatus = "배송중"
    @State var itemName = "ipTIME 외장케이스 WHITE HDD 3135 Plus"
    @State var itemImage = "itemImage" // image
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(deliveryStatus)")
                    .font(.headline)
            }
            HStack(alignment: .top){
                Image(itemImage)
                    .ImageResizeModifier()
                VStack(spacing: 10){
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
                        .modifier(PurchaseHistoryButtonModifier())
                        .frame(maxWidth: 80)
                        
                    }
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack{
                Button {
                    // 교환 반품 신청
                } label: {
                    Text("교환, 반품 신청")
                }
                .modifier(PurchaseHistoryButtonModifier())
                
                // TODO: - Delivery State에 따라서 버튼 바뀌어야 함 (배송조회/구매확정/리뷰작성)
                Button {
                    // 배송 조회
                } label: {
                    Text("배송 조회")
                }
                .modifier(PurchaseHistoryButtonModifier(textColor: .accentColor, borderColor: .accentColor))
                
            }
            .font(.callout)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .modifier(PurchaseHistoryButtonModifier())
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseHistoryView()
    }
}
