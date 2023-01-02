//
//  ReadyToPayView.swift
//  Payment
//
//  Created by Donghoon Bae on 2022/12/27.
//

import SwiftUI

// MARK: ReadyToPayView
/// 결제화면으로 가기 전 장바구니 페이지
/// 버튼을 통해 결제하기 페이지로 이동
struct ReadyToPayView: View {
    
    // PurchseInfo 소비자 정보 선언
    @State private var purchaseInfo: PurchaseInfo = PurchaseInfo(id: UUID().uuidString, userName: "박성민_1", userPhoneNumber: "010-XXXX-XXXX", depositorName: "박성민", recipient: Recipient(name: "박성민", phoneNumber: "010-XXXX-XXXX", adress: "서울시 중랑구 묵동 xxx-xxx", requestedTerm: "집 문앞에 놔주세요"), marketBasket: MarketBasket(id: UUID().uuidString, basketProducts: ["매직마우스", "애플워치", "에어팟맥스"]), payment: "150,000원", cashReceipt: CashReceipt(id: UUID().uuidString, incomDeduction: "소득공제정보", cashReceiptNumber: "현금영수증번호"), bankName: "신한은행")
    
    var body: some View {
        VStack {
            Text("배송지, 이름, 전화번호, 주소, 배송시 요청사항")
            Text("장바구니")
            Text("foreach로 뿌려줘 가격 수량 상품명")
            Text("삭제랑 수량변경")
            
            NavigationLink {
                
                // purchaseInfo 구매 정보 전달
                PaymentView(purchaseInfo: $purchaseInfo)
            } label: {
                Text("결제하기")
            }//modifier 받기
        }
    }
}

struct ReadyToPayView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyToPayView()
    }
}
