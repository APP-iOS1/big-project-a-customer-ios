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
                    item.itemIsChecked.toggle()
                } label: {
                    Image(systemName: item.itemIsChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(item.itemIsChecked ? .green : .gray)
                }

                Image(item.image)                                              
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                VStack(alignment: .trailing) {
                    HStack {
                        Text(item.itemName)
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
                        Text("가격: \(item.itemPrice)원")

                        Picker("count", selection: $item.itemListCount) {
                            ForEach(1..<10) { num in
                                Text("\(num)")
                            }
                        }
                        .colorMultiply(.black)
                        
                    }
                    .padding(.top, 5)
                }

            }
        }
    }
}

struct ShoppingBackDetailView_Previews: PreviewProvider {
    @State static var items = ShoppingCartItems(itemIsChecked: false, itemName: "MacBook Pro", itemPrice: 2060000, itemListCount: 0, image: "macbookpro")
    @StateObject static var vm = ShoppingCartViewModel()
    
    static var previews: some View {
        ShoppingBackDetailView(item: $items, vm: vm)
    }
}
