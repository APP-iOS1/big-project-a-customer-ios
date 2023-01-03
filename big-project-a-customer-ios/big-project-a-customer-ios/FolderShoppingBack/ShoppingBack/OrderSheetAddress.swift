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
		Address(recipient: "김딱콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false),
		Address(recipient: "김달콩", recipientAddress: "경기도 부천시 저쩌구동 153 어쩌구아파트, 592동 118호", recipientNumber: "010-9876-5432", isDefaultAddress: false)
	]
}

enum AddressOption {
    case defaultAddress
    case otherAddress
}

struct OrderSheetAddress: View {
	@Binding var totalPriceForBinding: Int
	@State var selectAddressIndex = 0
    
    @State private var selectAddressOptions: AddressOption = .defaultAddress
	
	// PurchseInfo 소비자 정보 선언
	@State private var purchaseInfo: PurchaseInfo = PurchaseInfo(id: UUID().uuidString, userName: "박성민_1", userPhoneNumber: "010-XXXX-XXXX", depositorName: "박성민", recipient: Recipient(name: "박성민", phoneNumber: "010-XXXX-XXXX", adress: "서울시 중랑구 묵동 xxx-xxx", requestedTerm: "집 문앞에 놔주세요"), marketBasket: MarketBasket(id: UUID().uuidString, basketProducts: ["매직마우스", "애플워치", "에어팟맥스"]), payment: "150,000원", cashReceipt: CashReceipt(id: UUID().uuidString, incomDeduction: "소득공제정보", cashReceiptNumber: "현금영수증번호"), bankName: "신한은행")
	
    var body: some View {
        VStack {
            Spacer().frame(height:30)
            
            Picker("주소 선택",selection: $selectAddressOptions) {
                Text("기본 배송지")
                    .tag(AddressOption.defaultAddress)
                Text("다른 배송지")
                    .tag(AddressOption.otherAddress)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            
            switch selectAddressOptions {
            case .defaultAddress:
                VStack {
                    ForEach(Array(Address.addresses.enumerated()), id: \.offset) { (index, address) in
                        if address.isDefaultAddress {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(address.recipient)
                                    .font(.title3)
                                    .bold()
                                Text(address.recipientAddress)
                                Text(address.recipientNumber)
                            }
                            .modifier(PurchaseHistoryButtonModifier(borderColor: .gray, lineWidth: 2))
                        }
                    }
//                    NavigationLink {
//                        ManageAddressView()
//                    } label: {
//                        //Image(systemName: "plus")
//                        Text("배송지 수정하기")
//                    }
//                    .modifier(PurchaseHistoryButtonModifier())
                    
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.horizontal, 20)
            case .otherAddress:
                AddAddressView()
                    .padding(.top, 30)
            }
            Spacer()
            
            NavigationLink {
                PaymentView(purchaseInfo: $purchaseInfo)
            } label: {
                Text("무통장 입금으로 결제하기")
            }
            .modifier(PurchaseHistoryButtonModifier(textColor: .white, borderColor: .accentColor, backgroundColor: .accentColor))
            .padding(.horizontal, 20)
            .navigationTitle("배송지 선택")
        }
    }
}

struct OrderSheetAddressCell: View {
	@Binding var selectAddressIndex: Int
	
	let index: Int
	var address: Address
	
	var body: some View {
        
		VStack(alignment: .leading, spacing: 10) {
			Text(address.recipient)
				.font(.title3)
				.bold()
			Text(address.recipientAddress)
			Text(address.recipientNumber)
			HStack {
				// 배송지 선택 버튼
				Button {
                    // 서버 통신 연결시 필요
//                  address.isDefaultAddress = true
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
