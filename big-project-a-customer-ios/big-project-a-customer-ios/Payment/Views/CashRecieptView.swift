//
//  CashRecieptView.swift
//  Payment
//
//  Created by 박성.._1 on 2022/12/28.
//

import SwiftUI

struct CashRecieptView: View {
    @Binding var isCashCheck: Bool
    @Binding var isCheckExpenditure: Bool
    @Binding var incomeDeduction: String
    @Binding var cashReceiptNumber: String
    var incomDeductions: [String] = ["소득공제 번호(휴대폰 번호)", "지출증빙 번호(사업자 번호)"]
    @Binding var purchaseInfo: PurchaseInfo

    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading ) {
                    HStack {
                        Button {
                            isCashCheck.toggle()
                        } label: {
                            Image(systemName: isCashCheck ? "checkmark.square.fill" : "square")
                        }
                        Text("현금영수증 신청")
                    }
                }
                Spacer()
            }
            
            if isCashCheck {
                VStack(alignment: .leading) {
                    Picker("incom deduction", selection: $incomeDeduction) {
                        ForEach(incomDeductions, id: \.self) { item in
                            Text("\(item)")
                        }
                    }
                    TextField("", text: $cashReceiptNumber).textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                }
                
                
                HStack(alignment: .top) {
                    Button {
                        isCheckExpenditure.toggle()
                        if isCheckExpenditure {
                            purchaseInfo.cashReceipt.incomDeduction = incomeDeduction
                            purchaseInfo.cashReceipt.cashReceiptNumber = cashReceiptNumber
                        } else {
                            purchaseInfo.cashReceipt.incomDeduction = ""
                            purchaseInfo.cashReceipt.cashReceiptNumber = ""
                        }
                    } label: {
                        Image(systemName: isCheckExpenditure ? "checkmark.square.fill" : "square")
                    }
                    Text("현금영수증 발급을 위하여 휴대폰번호 또는 현금 영수증카드번호를 수집하며, 5년간 처리에 동의합니다.")
                }
                
            } else {
                
            }
        }.padding(.horizontal)
    }
}

struct CashRecieptView_Previews: PreviewProvider {
    static var previews: some View {
        CashRecieptView(isCashCheck: Binding.constant(false), isCheckExpenditure: Binding.constant(false), incomeDeduction: Binding.constant("소득공제 번호(휴대폰 번호)"), cashReceiptNumber: Binding.constant("010XXXXXXXX"), purchaseInfo: Binding.constant(PurchaseInfo(id: UUID().uuidString, userName: "박성민_1", userPhoneNumber: "010-XXXX-XXXX", depositorName: "박성민", recipient: Recipient(name: "박성민", phoneNumber: "010-XXXX-XXXX", adress: "서울시 중랑구 묵동 xxx-xxx", requestedTerm: "집 문앞에 놔주세요"), marketBasket: MarketBasket(id: UUID().uuidString, basketProducts: ["매직마우스", "애플워치", "에어팟맥스"]), payment: "150,000원", cashReceipt: CashReceipt(id: UUID().uuidString, incomDeduction: "소득공제정보", cashReceiptNumber: "현금영수증번호"), bankName: "신한은행")))
    }
}
