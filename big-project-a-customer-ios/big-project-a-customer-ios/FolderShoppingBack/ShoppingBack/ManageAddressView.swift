//
//  ManageAddressView.swift
//  big-project-a-customer-ios
//
//  Created by 이학진 on 2023/01/02.
//

import SwiftUI

struct ManageAddressView: View {
    @State var selectAddressIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
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
                    Text("배송지 추가하기")
                }
                .modifier(PurchaseHistoryButtonModifier())
                
                Spacer()
            }
            .padding(.horizontal, 10)
            
            .padding(.bottom, 10)
            .padding(.horizontal, 10)
            .navigationTitle("배송지 선택")
        }
    }
}

struct ManageAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ManageAddressView()
    }
}
