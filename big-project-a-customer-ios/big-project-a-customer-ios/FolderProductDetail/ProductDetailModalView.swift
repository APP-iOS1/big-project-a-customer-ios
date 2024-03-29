//
//  ProductDetailModalView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/27.
//

import SwiftUI
import PopupView

struct ProductDetailModalView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var orderItemStore: OrderItemStore
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @ObservedObject var tempVM: TempViewModel
    
    @State private var count: Int = 1 // 수량
    @State private var isShowingSelectOptionPopup = false // 옵션 미선택 팝업
    @Binding var isShowingPutItemPopup: Bool // 장바구니 담기 성공 팝업
    @Binding var isActive: Bool

    @State private var isShowingPopup = false
    @State var isShowingLoginSheet = false
    
//    @EnvironmentObject var orderItemStore: OrderItemStore
//    @EnvironmentObject var signUpViewModel: SignUpViewModel


    let item: ItemInfoViewModel.FilteredItem


    var optionsArray: [String] {
        Array(tempVM.options.keys).sorted()
    }

    var body: some View {
        NavigationStack {

            VStack {
                // 옵션 마다 picker를 만들어준다.
                ForEach(Array(optionsArray.enumerated()), id: \.offset) { (index, key) in
                    // key: 옵션명(컬러, 사이즈 등)
                    HStack {
                        Text(key)

                        Spacer()

                        Picker(key, selection: $tempVM.selectedPicker[index]) {
                            Text("선택없음").tag(Optional<String>(nil))

                            ForEach(tempVM.options[key]!, id: \.0) { (option, price) in
                                Text("\(option) +\(price)원").tag("\(option)_\(price)")
                            }
                        }
                            .pickerStyle(.menu)
                            .modifier(PickerModifier())

                        // 피커를 선택하면 selection[index] 값이 바뀌고
                        .onChange(of: tempVM.selectedPicker[index], perform: { value in
                                let newValue = value.split(separator: "_").map { String($0) }

                                if !newValue.isEmpty {
                                    tempVM.selectedOptions[key] = (tempVM.options[key]!.filter { $0.0 == newValue[0] }.first!.0, Int(newValue[1])!)

                                    tempVM.calcTotalPrice()
                                }
                            })
                    }
                }.padding()

                HStack {
                    Text("옵션")

                    Spacer()

                    VStack {
                        ForEach(Array(tempVM.selectedOptions.sorted(by: { $0.1 < $1.1 })), id: \.key) { tuple in
                            HStack {
                                Spacer()
                                Text("\(tuple.value.0)(+\(tuple.value.1)원)")
                            }
                        }
                    }
                }
                    .padding()

                HStack {
                    Text("수량")

                    Spacer()

                    CustomStepper(value: $count, textColor: .black)
                }
                    .padding()

                HStack {
                    Text("가격")

                    Spacer()

                    Text("\(count * tempVM.totalPrice)원")
                }
                    .padding()

                HStack {
                    Button {

                        if (tempVM.selectedOptions.count != tempVM.options.count) {
                            // 옵션 선택 안한경우
                            isShowingSelectOptionPopup.toggle()
                        } else {
                            
                            // 받아온 아이템의 property 사용
                            // option, price만 tempViewModel의 값 사용
                            // amount는 count 변수 사용
                            
                            let newShoppingItem = OrderItemInfo(itemuid:item.itemId , storeId: item.storeId, itemName: item.name, itemImage: item.image, price: tempVM.totalPrice, amount: count, deliveryStatus: .beforePurchase, option: tempVM.selectedOptions)
                            
                            orderItemStore.createShoppingItem(uid: signUpViewModel.currentUser?.id ?? "", item: newShoppingItem)
                            
//                            orderItemStore.items.append(newShoppingItem)
                            
                            dismiss()
                            isShowingPutItemPopup.toggle()
 
                        }
 
                    } label: {
                        HStack {
                            Spacer()
                            Text("장바구니 담기")
                                .fontWeight(.bold)
                            Spacer()
                        }
                            .modifier(ColoredButtonModifier(cornerRadius: 10))
                    }
                    

                    Button {

                        // 로그인이 되지 않은 상태라면 로그인 뷰를 띄운다.
                        if signUpViewModel.currentUser?.userEmail == nil {
                            isShowingLoginSheet = true

                        } else {
                            if (tempVM.selectedOptions.count != tempVM.options.count) {
                                 isShowingSelectOptionPopup.toggle()
                            } else {
                                dismiss()
                                // 구매하기 뷰 (주소입력) 으로 이동
                                isActive.toggle()
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("구매하기")
                                .fontWeight(.bold)
                            Spacer()
                        }
                            .modifier(ColoredButtonModifier(cornerRadius: 10))
                    }
                }

                Spacer()
            }
        }
        .popup(isPresented: $isShowingSelectOptionPopup, position: .bottom, autohideIn: 1) {
            Text("⚠️ 옵션을 모두 선택해 주세요.")
                .frame(width: 250, height: 60)
                .background(Color.secondary)
                .foregroundColor(.white)
                .cornerRadius(10.0)
        }
        .fullScreenCover(isPresented: $isShowingLoginSheet) {
            LoginView()
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
                }
            }, label: {
                    Image(systemName: "minus.square")
                        .foregroundColor(value == 1 ? .gray : .black)
                })

            Text("\(value)").font(.system(.caption, design: .rounded))
                .foregroundColor(textColor)

            Button(action: {
                self.value += self.step
            }, label: {
                    Image(systemName: "plus.square")
                        .foregroundColor(.black)
                })
        }
    }
}

struct ProductDetailModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailModalView(tempVM: TempViewModel(), isShowingPutItemPopup: .constant(false), isActive: .constant(false), item: ItemInfoViewModel.FilteredItem(name: "", price: 0.0, image: "", itemId: "", storeId: "", itemAllOption: [:]))
    }
}
