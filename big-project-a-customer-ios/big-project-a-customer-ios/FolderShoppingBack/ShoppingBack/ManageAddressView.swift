//
//  ManageAddressView.swift
//  big-project-a-customer-ios
//
//  Created by 이학진 on 2023/01/02.
//

import SwiftUI

struct ManageAddressView: View {
    @Environment(\.dismiss) private var dissmiss
    @ObservedObject var myPageViewModel: MyPageViewModel
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack(spacing: 20) {
                    
                    Text("수령인")
                        .foregroundColor(.secondary)
                    
                    TextField("수령인", text: $name)
                        .modifier(AddressEditModifier())
                }
                
                HStack(spacing: 34.5) {
                    Text("주소")
                        .foregroundColor(.secondary)
                    
                    TextField("주소", text: $address)
                        .modifier(AddressEditModifier())
                }
                
                HStack(spacing: 20) {
                    Text("연락처")
                        .foregroundColor(.secondary)
                    
                    TextField("주소", text: $phoneNumber)
                        .modifier(AddressEditModifier())
                }
            }
            .padding()
            
            Spacer()
            Button(action: {
                finishEdit()
                dissmiss()
            }, label: {
                Text("수정 완료")
            })
            .modifier(PurchaseHistoryButtonModifier(textColor: .white, borderColor: .accentColor, backgroundColor: .accentColor))
            .padding()
            .navigationTitle("기본배송지 수정")
        }
        .onAppear {
            name = myPageViewModel.users.name
            address = myPageViewModel.users.userAddress
            phoneNumber = myPageViewModel.users.phoneNumber
        }
    }
    
    /// 수정 완료 버튼을 누르면 호출되는 함수로
    /// 텍스트 필드로 입력 받아 수령인, 주소, 연락처를 변경한다
    func finishEdit() {
        myPageViewModel.users.name = name
        myPageViewModel.users.userAddress = address
        myPageViewModel.users.phoneNumber = phoneNumber
    }
}

struct AddressEditModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(.gray)
    }
}

struct ManageAddressView_Previews: PreviewProvider {
    @StateObject static var myPageViewModel = MyPageViewModel()
    static var previews: some View {
//        NavigationStack {
//            MyPageInfoDetailView()
//        }
        ManageAddressView(myPageViewModel: myPageViewModel)
    }
}
