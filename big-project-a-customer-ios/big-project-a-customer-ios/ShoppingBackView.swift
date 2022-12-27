//
//  ShoppingBackView.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2022/12/27.
//

import SwiftUI

struct ShoppingCartItems: Identifiable {
    var id = UUID().uuidString
    var itemIsChecked: Bool
    var itemName: String
    var itemPrice: Int
    var itemListCount: Int
    var image: String
}

class ShoppingCartViewModel: ObservableObject {
    // ShoppingCartItems 약자
    @Published var sCItems: [ShoppingCartItems] = [
        ShoppingCartItems(itemIsChecked: false, itemName: "MacBook Pro", itemPrice: 2060000, itemListCount: 0, image: "macbookpro"),
        ShoppingCartItems(itemIsChecked: false, itemName: "MacBook Air", itemPrice: 1690000, itemListCount: 0, image: "macbookair"),
        ShoppingCartItems(itemIsChecked: false, itemName: "Iphone 14", itemPrice: 1550000, itemListCount: 0, image: "iphone14")
    ]
    @Published var totalItemsPrice: Int = 0
    @Published var totalItemsCount: Int = 0
}

struct ShoppingBackView: View {
    @State private var isCheckedAll = false
//    @State private var isChecked = false
//    @State private var itemName = "macbookpro"
//    @State private var price: Int = 1000
//    @State private var count: Int = 0
//    @State private var image = "macbook.and.iphone"
    @State private var shippingCost = 3000
    
    @ObservedObject var vm: ShoppingCartViewModel = ShoppingCartViewModel()
    
    
    var body: some View {
        // MARK: head
        VStack {
            Text("장바구니")
                .font(.title2.bold())
            
            Section {
                HStack {
                    Button {
                        isCheckedAll.toggle()
                        checkBoxAll()
                    } label: {
                        Image(systemName: isCheckedAll ? "checkmark.square.fill" : "square")
                            .foregroundColor(isCheckedAll ? .green : .gray)
                    }
                    
                    Text("모두선택")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("선택삭제")
                        .font(.headline)
                }
            }
            .padding(.top, 5)
            
            Divider()
                .frame(minHeight: 3)
                .overlay(Color.gray.brightness(0.3))
            
            Spacer()
            
            // MARK: body
            ScrollView {
                
                ForEach($vm.sCItems) { item in
                    ShoppingBackDetailView(item: item)
                    .padding(.vertical)
                    
                    Divider()
                }
            }
            
            // MARK: tail
            Section {
                VStack {
                    HStack {
                        Text("총 상품금액")
                        Spacer()
                        Text("\(price)원")
                    }
                    HStack {
                        Text("총 배송비")
                        Spacer()
                        Text("+ \(shippingCost)원")
                    }
                    HStack {
                        Text("결제금액")
                        Spacer()
                        Text("\(price+shippingCost)원")
                    }
                    .font(.title.bold())
                    .padding(.top, 5)

                    HStack {
                        Text("\(count+1)개")
                        Spacer()
                        Button {

                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(maxWidth: 200, maxHeight: 50)
                                Text("바로구매")
                                    .foregroundColor(.white)
                            }
                        }

                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func checkBoxAll() {
//        if isCheckedAll {
//            for i in vm.sCItems {
//                i.itemIsChecked = true
//            }
//        } else {
//            for i in vm.sCItems {
//                i.itemIsChecked = false
//            }
//        }
    }
}

struct ShoppingBackView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingBackView()
    }
}
