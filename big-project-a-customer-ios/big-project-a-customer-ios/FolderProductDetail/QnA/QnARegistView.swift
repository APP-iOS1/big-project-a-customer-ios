//
//  QnARegistView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2023/01/02.
//

import SwiftUI

struct QnARegistView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            TextField("문의할 내용을 입력해주세요.", text: $text,  axis: .vertical)
                .lineLimit(10...15)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 4)
            
            Text("주민번호, 전화번호, 이메일 등 개인정보를 남기면 타인에 의해 도용될 수 있습니다. 개인정보는 상품문의에 남기지 말아주세요.")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Spacer()
                    
                    Text("등록하기")
                    
                    Spacer()
                }
            }
            .tint(.accentColor)
            .buttonStyle(.bordered)
            .controlSize(.large)
            
            Spacer()
        }
        .padding()
        
        .navigationTitle("문의하기")
    }
}

struct QnARegistView_Previews: PreviewProvider {
    static var previews: some View {
        QnARegistView()
    }
}
