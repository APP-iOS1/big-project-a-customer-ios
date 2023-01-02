//
//  AddAddressView.swift
//  big-project-a-customer-ios
//
//  Created by 이민경 on 2022/12/28.
//

import SwiftUI

struct AddAddressView: View {
    @State private var recipient = "" // 받는 사람
    @State private var recipientAddress = 0 // 주소(우편번호)
    @State private var recipientNumber = "" // 받는 사람 휴대폰 번호
    
    var requirements = ["문 앞",
                        "직접 받고 부재 시 문 앞",
                        "경비실",
                        "택배함",
                        "기타사항"]
    @State private var selectedRequirement = "문 앞" // 배송 요청사항
    @State private var isDefaultAddress = false // 기본 배송지 선택
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            TextField("받는 사람", text: $recipient)
                .font(.headline)
            Divider()
            Button {
                // TODO: 우편번호 찾기
                /// 우편번호 검색해서 주소 recipientAddress에 저장하기
                /// webkit으로 카카오 주소찾기 연동하기
            } label: {
                HStack{
                    Text("우편번호 찾기")
                    Spacer()
                    Image(systemName: "magnifyingglass")
                }
            }
            .font(.headline)
            Divider()
            TextField("휴대폰 번호", text: $recipientNumber)
                .font(.headline)
            Divider()
            HStack{
                Text("배송 요청사항")
                Picker("요청사항 선택", selection: $selectedRequirement) {
                    ForEach(requirements, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }
            Divider()
//            HStack{
//                Button {
//                    isDefaultAddress.toggle()
//                } label: {
//                    Image(systemName: isDefaultAddress ? "checkmark.square.fill" : "square")
//                        .foregroundColor(isDefaultAddress ? .green : .gray)
//                }
//                Text("기본 배송지로 설정")
//            }.modifier(TextCaptionGrayModifier())
//            Button {
//                // 새로운 배송지 저장
//            } label: {
//                Text("저장")
//            }
//            .modifier(PurchaseHistoryButtonModifier(textColor: .white, borderColor: .accentColor, backgroundColor: .accentColor))
        }
        .textFieldStyle(.plain)
        .padding(.horizontal, 20)
    }
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView()
    }
}
