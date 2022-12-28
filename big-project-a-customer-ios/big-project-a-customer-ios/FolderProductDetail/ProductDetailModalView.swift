//
//  ProductDetailModalView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/27.
//

import SwiftUI

struct ProductDetailModalView: View {
    @ObservedObject var tempVM: TempViewModel = TempViewModel()
    
//    @Binding var options: [String: [String]]
    @State var selectedColor = ""
    @State var count: Int = 1
    @State private var selection = ""
    // FIXME: - 유저가 중복선택할 경우를 생각해서 Set을 적용할지 생각해보기.
    @State private var selectedOptions: [String] = []
    
    var colors = ["red", "green", "blue"]
    var price: Int = 50000
    
    var optionsArray: [String] {
        Array(tempVM.options.keys).sorted()
    }
    
    var body: some View {
        
        VStack {
            // 옵션 마다 picker를 제공
            ForEach(optionsArray, id:\.self) { key in
                // FIXME: - Picker Error
                Picker("", selection: $selection) {
                    ForEach(tempVM.options[key]!, id: \.0) {
                        Text("\($0) \($1)")
                    }
                }
                .pickerStyle(.menu)
                .background(.white)
                .cornerRadius(15)
                .padding()
            }
            .onReceive([self.selection].publisher.first()) { (value) in
                selectedOptions.append(value)
            }
            
            HStack {
                Text("수량")
                
                Spacer()
                
                CustomStepper(value: $count, textColor: .black)
            }
            .padding()
            
            HStack {
                Text("가격")
                
                Spacer()
                
                Text("\(count * price)원")
            }
            .padding()
            
            
        }
    }
}

struct CustomStepper: View {
    @Binding var value: Int
    var textColor: Color
    var step = 1
    
    var body: some View {
        HStack {
            Button(action: {
                if self.value > 1 {
                    self.value -= self.step
                    self.feedback()
                }
            }, label: {
                Image(systemName: "minus.square")
                    .foregroundColor(value == 1 ? .gray : .black)
            })
            
            Text("\(value)").font(.system(.caption, design: .rounded))
                .foregroundColor(textColor)
            
            Button(action: {
                self.value += self.step
                self.feedback()
                
            }, label: {
                Image(systemName: "plus.square")
                    .foregroundColor(.black)
            })
        }
    }
    
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

struct ProductDetailModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailModalView()
    }
}
