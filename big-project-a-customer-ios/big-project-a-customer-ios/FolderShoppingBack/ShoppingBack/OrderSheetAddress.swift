//
//  OrderSheetAddress.swift
//  big-project-a-customer-ios
//
//  Created by do hee kim on 2022/12/28.
//

import SwiftUI

// MARK: - 임시 배송지 데이터 모델
struct Address: Identifiable {
    var id = UUID().uuidString
    var recipient: String
    var recipientAddress: String
    var recipientNumber: String
    // TODO: 기본 배송지 저장하는 구조 있는지? 질문?
    var isDefaultAddress: Bool
}

extension Address {
    static let addresses: [Address] = [
        Address(recipient: "이알콩", recipientAddress: "경기도 광명시 어쩌구동 235 저쩌구아파트, 182동 306호", recipientNumber: "010-1234-5678", isDefaultAddress: true),
        Address(recipient: "김달콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false),
        Address(recipient: "김달콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false)
    ]
}

struct OrderSheetAddress: View {
    @Binding var totalPriceForBinding: Int
    @State var selectAddressIndex = 0
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(Array(Address.addresses.enumerated()), id: \.offset) { (index, address) in
                    if index == selectAddressIndex {
                        OrderSheetAddressCell(selectAddressIndex: $selectAddressIndex, index: index, address: address)
                            .modifier(PurchaseHistoryButtonModifier(borderColor: .accentColor, lineWidth: 2))
                    } else {
                        OrderSheetAddressCell(selectAddressIndex: $selectAddressIndex, index: index, address: address)
                            .modifier(PurchaseHistoryButtonModifier())
                    }
                }
                
                NavigationLink {
                    AddAddressView()
                } label: {
                    Image(systemName: "plus")
                    Text("배송지 추가")
                }
                .modifier(PurchaseHistoryButtonModifier())
                
                Spacer()
                
            }
            .padding(.horizontal, 10)
            
            NavigationLink {
                // 결제하러 가기
            } label: {
                Text("무통장 입금으로 결제하기")
            }
            .modifier(PurchaseHistoryButtonModifier(textColor: .white, borderColor: .accentColor, backgroundColor: .accentColor))
            .padding(.bottom, 10)
            .padding(.horizontal, 10)
            .navigationTitle("배송지 선택")
        }
    }
}

struct OrderSheetAddressCell: View {
    @Binding var selectAddressIndex: Int
    
    let index: Int
    let address: Address
    
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
        .navigationTitle("배송지 선택")
    }
}

struct OrderSheetAddress_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheetAddress(totalPriceForBinding: .constant(12345))
    }
}