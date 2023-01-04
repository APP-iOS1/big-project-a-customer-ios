//
//  ShoppingBackDetailView.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2022/12/27.
//

import SwiftUI

struct ShoppingBackDetailView: View {
//    @Binding var item1: ShoppingCartItems
    @Binding var item: OrderItemInfo
    
//    @ObservedObject var vm: ShoppingCartViewModel
    @EnvironmentObject var shoppingStores: OrderItemStore
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    @Binding var checkDict: [String: Bool]
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            HStack(alignment: .top) {
                Button {
                    checkDict[item.itemuid]?.toggle()
                } label: {
                    
//                    Image(systemName: checkDict[item.itemuid] ?? false ? "checkmark.square.fill" : "square"))
//                        .modifier(CheckBoxModifier(isCheckedAll: checkDict[item.itemuid]))
//                    Image(systemName: item1.isChecked ? "checkmark.square.fill" : "square")
//                        .modifier(CheckBoxModifier(isCheckedAll: item1.isChecked))
                    Image(systemName: "checkmark.square.fill")
                        .modifier(CheckBoxModifier(isCheckedAll: true))
                }
                
                Image(item.itemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .trailing) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.itemName)
                                .font(.title3)
                            Text("(\(item.price)원)")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            shoppingStores.deleteShoppingItem(uid: signUpViewModel.currentUser?.id ?? "", itemUID: item.itemuid)
//                            vm.deleteItem(item)
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .modifier(XButtonModifier())
                            
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        ForEach(item.option.sorted(by: { lhs, rhs in lhs.key > rhs.key }), id: \.key) { key, value in
                            HStack {
                                Text("\(key) : \(value.0)")
                                    .font(.subheadline)
                                if value.1 > 0 {
                                    Text("(+\(value.1)원)")
                                        .modifier(OptionTextModifier())
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 1)
                    
                    
                    VStack(alignment: .leading) {
//                        Text("옵션 포함 가격 : \(item.price + (item.options).values.map{$0.1}.reduce(0,+))원")
                        
                        HStack {
                            Spacer()
                            
                            Picker("count", selection: $item.amount) {
                                ForEach(1..<10) { num in
                                    Text("\(num)개")
                                }
                            }
                            .modifier(PickerModifier())
                            .onChange(of: item.amount) { newValue in
                                shoppingStores.updateShoppingItem(uid: signUpViewModel.currentUser?.id ?? "", itemUID: item.itemuid, newAmount: newValue)
                            }
                        }
                    }
                    .padding(.top, 5)
                }
                .padding(.leading, 5)
                
            }
        }
    }
}

//struct ShoppingBackDetailView_Previews: PreviewProvider {
//    @State static var items = ShoppingCartItems(name: "MacBook Pro", price: 2060000,image: "macbookpro", amount: 0,isChecked: true, options: ["색상" : ("스페이스 그레이", 0), "저장용량" : ("512GB", 0), "RAM" : ("8GB", 0)])
//    @StateObject static var vm = ShoppingCartViewModel()
//    
//    static var previews: some View {
//        ShoppingBackDetailView(item: $items, vm: vm)
//    }
//}
