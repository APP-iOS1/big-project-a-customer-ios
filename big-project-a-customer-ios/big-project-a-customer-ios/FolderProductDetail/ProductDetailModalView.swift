//
//  ProductDetailModalView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/27.
//

import SwiftUI

struct ProductDetailModalView: View {
    // @Binding var options: [String: [String]]
    var colors = ["red", "green", "blue"]
    @State var selectedColor = ""
    @State var count: Int = 1
    var price: Int = 50000
    
    var body: some View {
        VStack {
            Picker("Choose a color", selection: $selectedColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            .background(.yellow)
            .cornerRadius(15)
            .padding()
            .onReceive([self.selectedColor].publisher.first()) { (value) in
                // append
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

struct CustomStepper : View {
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
