//
//  ProductDetailModalView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/27.
//

import SwiftUI

struct ProductDetailModalView: View {
    //    @ObservedObject var tempVM: TempViewModel = TempViewModel()

    @Binding var options: [String: [String]]
    @State var count: Int = 1
    @State private var selection = ""
    // FIXME: - 유저가 중복선택할 경우를 생각해서 Set을 적용할지 생각해보기.

    @State private var selectedOptions: [(optionName: String, option: String, optionPrice: Int)] = []

    // 기본 가격(옵션 제외)
    var basePrice: Int = 50000
    // 옵션 추가 금액
    var optionPrice: Int = 0

    var optionsArray: [String] {
        Array(options.keys).sorted()
    }

    var body: some View {

        VStack {
            // 옵션 마다 picker를 만들어준다.
            ForEach(Array(optionsArray.enumerated()), id: \.offset) { (index, key) in
                // key: 옵션명(컬러, 사이즈 등)
                HStack {
                    Text(key)

                    Spacer()

                    // FIXME: - Picker Error
                    Picker(key, selection: $selection) {
                        Text("선택없음").tag(Optional<String>(nil))
                        ForEach(options[key]!, id: \.self) { item in
                            let value = item.split(separator: "_").map { String($0) }
                            Text("\(value[0]) +\(value[1])원").tag(Optional(item))
                        }
                    }
//                    .onChange(of: selection, perform: { value in
//                        if !value.isEmpty {
//                            let newValue = value.split(separator: "_").map { String($0) }
//                            let newTuple = (String(key), String(newValue[0]), Int(newValue[1])!)
//                            selectedOptions.append(newTuple)
//                        } else {
//                            print(value)
//                        }
//                    })
                    .onReceive([self.selection].publisher.first()) { (value) in
//                         선택 옵션을 selectedOptions 딕셔너리에 업데이트
                        if !value.isEmpty {
                            let newValue = value.split(separator: "_").map { String($0) }
                            let newTuple = (String(key), String(newValue[0]), Int(newValue[1])!)
                        }
                        
                    }
                        .pickerStyle(.menu)
                        .background(.white)
                        .cornerRadius(15)
                }
                    .padding()

            }

            HStack {
                Text("수량")

                Spacer()

                CustomStepper(value: $count, textColor: .black)
            }
                .padding()

            HStack {
                Text("옵션")
                Spacer()
            }
                .padding()

            VStack {

                ForEach(selectedOptions, id: \.0) { tuple in
                    HStack {
                        Spacer()
                        Text("\(tuple.1)(+\(tuple.2)원)")
                    }
                }
            }
                .padding()

            HStack {
                Text("가격")

                Spacer()

                Text("\(count * (basePrice + optionPrice))원")
            }
                .padding()
            
            HStack {
                Button {
                    // FIXME: - 장바구니 ViewModel에 아이템 추가하는 로직 추가
                } label: {
                    HStack {
                        Spacer()
                        Text("장바구니 담기")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .modifier(ProductButtonModifier(color: .pink))
                }
                .tint(.white)
                
                Button {
                    // FIXME: - 페이지 이동
                } label: {
                    HStack {
                        Spacer()
                        Text("구매하기")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .modifier(ProductButtonModifier(color: .pink))
                }
                .tint(.white)
            }
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
        ProductDetailModalView(options: .constant([
            "사이즈": ["S", "M", "L"],
            "컬러": ["레드", "블루", "블랙"]
            ]))
    }
}
