//
//  MyPageAddressEditView.swift
//  big-project-a-customer-ios
//
//  Created by TAEHYOUNG KIM on 2023/01/02.
//

import SwiftUI


// MARK: - 임시 배송지 데이터 모델
struct Address2: Identifiable {
    var id = UUID().uuidString
    var recipient: String
    var recipientAddress: String
    var recipientNumber: String
    // TODO: 기본 배송지 저장하는 구조 있는지? 질문?
    var isDefaultAddress: Bool
}

extension Address2 {
    static let addresses: [Address] = [
        Address(recipient: "이알콩", recipientAddress: "경기도 광명시 어쩌구동 235 저쩌구아파트, 182동 306호", recipientNumber: "010-1234-5678", isDefaultAddress: true),
        Address(recipient: "김딱콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false),
        Address(recipient: "김달콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false)
    ]
}

struct MyPageAddressEditView: View {
    @State var selectAddressIndex = 0
    
    // PurchseInfo 소비자 정보 선언
    @State private var purchaseInfo: PurchaseInfo = PurchaseInfo(id: UUID().uuidString, userName: "박성민_1", userPhoneNumber: "010-XXXX-XXXX", depositorName: "박성민", recipient: Recipient(name: "박성민", phoneNumber: "010-XXXX-XXXX", adress: "서울시 중랑구 묵동 xxx-xxx", requestedTerm: "집 문앞에 놔주세요"), marketBasket: MarketBasket(id: UUID().uuidString, basketProducts: ["매직마우스", "애플워치", "에어팟맥스"]), payment: "150,000원", cashReceipt: CashReceipt(id: UUID().uuidString, incomDeduction: "소득공제정보", cashReceiptNumber: "현금영수증번호"), bankName: "신한은행")
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(Array(Address2.addresses.enumerated()), id: \.offset) { (index, address) in
                    if index == selectAddressIndex {
                        OrderSheetAddressCell(selectAddressIndex: $selectAddressIndex, index: index, address: address)
                            .modifier(PurchaseHistoryButtonModifier(borderColor: .accentColor, lineWidth: 2))
                    } else {
                        OrderSheetAddressCell(selectAddressIndex: $selectAddressIndex, index: index, address: address)
                            .modifier(PurchaseHistoryButtonModifier())
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 10)
            
            NavigationLink {
                AddAddressView()
            } label: {
                Image(systemName: "plus")
                Text("배송지 추가")                        }
            .modifier(PurchaseHistoryButtonModifier())
            .padding(.bottom, 10)
            .padding(.horizontal, 10)
            
            
            Spacer()
        }
        .navigationTitle("배송지 선택")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct MyPageAddressEditViewCell: View {
    @Binding var selectAddressIndex: Int
    
    let index: Int
    let address: Address2
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(address.recipient)
                .font(.title3)
                .bold()
            Text(address.recipientAddress)
            Text(address.recipientNumber)
            HStack {
                // 배송지 수정 버튼
                Button {
                    
                } label: {
                    Text("수정")
                }
                .modifier(PurchaseHistoryButtonModifier(textColor: .blue))
                // 배송지 선택 버튼
                Button {
                    selectAddressIndex = index
                } label: {
                    Text("선택")
                }
                .modifier(PurchaseHistoryButtonModifier(textColor: .white, borderColor: .accentColor, backgroundColor: .accentColor))
                
            }
        }
        .padding()
    }
    
}


struct MyPageAddressEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageAddressEditView()
        }
    }
}
