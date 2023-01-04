//
//  PaymentCompleteView.swift
//  Payment
//
//  Created by tae on 2022/12/27.
//

import SwiftUI

struct PaymentCompleteView: View {
    @ObservedObject private var orderStore: OrderStore = OrderStore()
    @EnvironmentObject private var signupViewModel: SignUpViewModel
    @Binding var purchaseInfo: PurchaseInfo
    var isCashCheck: Bool
    
    /// 전달받은 배송지 주소
    let shippingAddress: Address
    
    /// 주문완료된 아이템들
    let orderedItems: [OrderItemInfo]
    
    var body: some View {
        VStack {
            ZStack {
                Color(.systemFill)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack(spacing: 10) {
                        Text("주문완료")
                            .font(.title)
                        Text("주문 번호: XXXXXXXXXX")
                        Text("아래 가상계좌로 입금해주시면 정상적으로 결제 완료처리가 됩니다.")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                        HStack {
                            Text("가상 계좌 정보")
                            Spacer()
                        }
                        
                        Divider()
                        VStack {
                            ZStack {
                                Color(.systemFill)
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        
                                        ///소비자 정보 받아서 정보 입력
                                        PaymentInfoView(keyInfo: "은행", valueInfo: purchaseInfo.bankName)
                                        PaymentInfoView(keyInfo: "입금하실 금액", valueInfo: purchaseInfo.payment)
                                        PaymentInfoView(keyInfo: "예금주 명", valueInfo: purchaseInfo.depositorName)
                                        PaymentInfoView(keyInfo: "입금 기한", valueInfo: "\(Date().plusAdding(hours: 3))")
                                        
                                        if isCashCheck {
                                            PaymentInfoView(keyInfo: "소득공제정보", valueInfo: purchaseInfo.cashReceipt.incomDeduction)
                                            PaymentInfoView(keyInfo: "현금영수증번호", valueInfo: purchaseInfo.cashReceipt.cashReceiptNumber)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top,80)
                            NavigationLink {
                                HomeMenuView()
                            } label: {
                                Text("홈 뷰로 이동하기")
                            }
                            
                            
                        }
                        .frame(height: 300)
                        Spacer()
                    }
                    .padding(10)
                }
            }
        }
        .onAppear {
            Task {
                await orderStore.createOrderItems(
                    currentUserUid: signupViewModel.currentUser?.id ?? "",
                    address: shippingAddress.recipientAddress,
                    payment: .byAccount,
                    orderItems: orderedItems
                )
            }
        }
    }
}

struct PaymentInfoView: View {
    var keyInfo: String
    var valueInfo: String
    
    var body: some View {
        ZStack(alignment:.leading) {
            HStack {
                VStack(alignment:.leading) {
                    Text("\(keyInfo)")
                        .font(.title2)
                    Text("- \(valueInfo)")
                }
                Spacer()
            }
            
        }
        .padding(10)
        .frame(height: 50)
    }
}

extension Date {
    func adding(minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func plusAdding(hours: Int) -> Date {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "HH"
        var current_time_string = formatter_time.string(from: Date())
        return Calendar.current.date(byAdding: .hour, value: Int(current_time_string)! + hours, to: self)!
    }
}

let startTime = Date.now
let endTime = startTime.adding(hours: 3)

struct PaymentCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCompleteView(purchaseInfo: Binding.constant(PurchaseInfo(id: UUID().uuidString, userName: "박성민_1", userPhoneNumber: "010-XXXX-XXXX", depositorName: "박성민", recipient: Recipient(name: "박성민", phoneNumber: "010-XXXX-XXXX", adress: "서울시 중랑구 묵동 xxx-xxx", requestedTerm: "집 문앞에 놔주세요"), marketBasket: MarketBasket(id: UUID().uuidString, basketProducts: ["매직마우스", "애플워치", "에어팟맥스"]), payment: "150,000원", cashReceipt: CashReceipt(id: UUID().uuidString, incomDeduction: "소득공제정보", cashReceiptNumber: "현금영수증번호"), bankName: "신한은행")), isCashCheck: true, shippingAddress: Address.addresses[0], orderedItems: [])
    }
}
