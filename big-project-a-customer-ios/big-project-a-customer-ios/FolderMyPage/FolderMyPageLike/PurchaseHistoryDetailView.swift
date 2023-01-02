//
//  PurchaseHistoryDetailView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/28.
//

import SwiftUI

struct PurchaseHistoryDetailView: View {
    @State private var orderNumber = "32000101798745"
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("2022.12.3 주문")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                    Text("주문번호 \(orderNumber)")
                        .modifier(TextCaptionGrayModifier())
                }.padding(.horizontal, 5)
                
                PurchaseDetail()
            }
            .padding(10)
        }
    }
}

struct PurchaseDetail: View {
    @ObservedObject var orderStore: OrderInfoViewModel = OrderInfoViewModel()
    
    @State var price = 29400
    @State var deliveryFee = 0
    @State var payment = "국민카드"
    
    @State var userName = "홍길동"
    @State var userAddress = "서울특별시 종로구 종로3길 17"
    @State var phoneNumber = "010-1234-5678"
    @State var deliveryRequest = "문 앞"
    @State var check = false
    
    // 전체 가격을 연산프로퍼티로 구하는데, 연산프로퍼티 사용시 타입 명시가 필요함to
    var totalPrice: Int {
        return price + deliveryFee
    }
    
    var body: some View{
        VStack(spacing: 15){
            VStack(alignment: .leading, spacing: 10){
                Text("결제 정보")
                    .font(.headline)
                HStack{
                    Text("상품 가격")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(price)")
                }
                HStack{
                    Text("배송비")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(deliveryFee)")
                }
                Divider()
                    .padding(.vertical,15)
                HStack{
                    Text("\(payment)")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(totalPrice)")
                }
                HStack{
                    Text("총 결제 금액")
                        .font(.headline)
                    Spacer()
                    Text("\(totalPrice)")
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .modifier(PurchaseHistoryButtonModifier())
            
            VStack(alignment: .leading, spacing: 10){
                Text("\(userName)")
                    .font(.headline)
                Text("\(userAddress)")
                    .foregroundColor(.gray)
                Text("\(phoneNumber)")
                Divider()
                    .padding(.vertical,15)
                HStack{
                    Text("배송요청사항")
                        
                    Spacer()
                    Text("\(deliveryRequest)")
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .modifier(PurchaseHistoryButtonModifier())
            
            ForEach(0..<3){ _ in
                VStack {
                    PurchaseListCell(orderStore: orderStore, order: OrderInfo(orderDate: "2022. 12. 27", itemAmount: 1, price: 24900, deliveryStatusText: "배송중", itemName: "유그린 메탈쉘 외장하드 케이스 C to USB3.0", itemImage: "itemImage"), index: 1, isDeliveryCompleted: $check)
                }
            }
            Button {
                // 구매 후기 쓰기
            } label: {
                Text("구매 후기 쓰기")
            }
            .modifier(PurchaseHistoryButtonModifier())
            Button {
                // 주문 내역 삭제
            } label: {
                Text("주문 내역 삭제")
            }
            .modifier(PurchaseHistoryButtonModifier())

        }
        .padding(10)
    }
}
struct PurchaseHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseHistoryDetailView()
    }
}
