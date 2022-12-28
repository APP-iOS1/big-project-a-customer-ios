//
//  ShoppingBackDetailView.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2022/12/27.
//

import SwiftUI

struct ShoppingBackDetailView: View {
    @Binding var item: ShoppingCartItems
    @ObservedObject var vm: ShoppingCartViewModel
    
    
    var body: some View {
        VStack(alignment: .trailing) {

            HStack(alignment: .top) {
                Button {
                    item.isChecked.toggle()
                } label: {
                    Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(item.isChecked ? .green : .gray)
                }

                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                VStack(alignment: .trailing) {
                    HStack {
                        Text(item.name)
                            .font(.title3)

                        Spacer()

                        Button {
                            let index = vm.sCItems.firstIndex {
                                $0.id == item.id
                            }
                            
                            vm.sCItems.remove(at: index!)
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }

                    VStack(alignment: .trailing) {
                        Text("가격 : \(item.price)원")

                        HStack {
                            Text("색상 : \(item.option.color)")
                                .padding(.leading)
                                .font(.subheadline)
                                
                            
                            Spacer()
                            
                            Picker("count", selection: $item.option.amount) {
                                ForEach(1..<10) { num in
                                    Text("\(num)개")
                                }
                            }
                            .colorMultiply(.black)
                        }
                        .background {
                            Color.gray.brightness(0.35)
                        }
                        .cornerRadius(10)
                        
                    }
                    .padding(.top, 5)
                }

            }
        }
    }
}

struct ShoppingBackDetailView_Previews: PreviewProvider {
    @State static var items = ShoppingCartItems(name: "MacBook Pro", price: 2060000,image: "macbookpro",isChecked: true, option: Option(color: "spacegray", amount: 0))
    @StateObject static var vm = ShoppingCartViewModel()
    
    static var previews: some View {
        ShoppingBackDetailView(item: $items, vm: vm)
    }
}
