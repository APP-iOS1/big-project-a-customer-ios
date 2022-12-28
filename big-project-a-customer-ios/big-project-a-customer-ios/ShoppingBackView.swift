//
//  ShoppingBackView.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2022/12/27.
//

import SwiftUI

// MARK: - 임시 장바구니 데이터 모델
struct ShoppingCartItems: Identifiable {
    var id = UUID().uuidString
    var itemIsChecked: Bool
    var itemName: String
    var itemPrice: Int
    var itemListCount: Int
    var image: String
}

// MARK: - 임시 장바구니 뷰 모델
/// 장바구니에 담긴 item들을 가지고 있음
class ShoppingCartViewModel: ObservableObject {
    // ShoppingCartItems 약자
    @Published var sCItems: [ShoppingCartItems] = [
        ShoppingCartItems(itemIsChecked: true, itemName: "MacBook Pro", itemPrice: 2060000, itemListCount: 0, image: "macbookpro"),
        ShoppingCartItems(itemIsChecked: true, itemName: "MacBook Air", itemPrice: 1690000, itemListCount: 0, image: "macbookair"),
        ShoppingCartItems(itemIsChecked: true, itemName: "Iphone 14", itemPrice: 1550000, itemListCount: 0, image: "iphone14")
    ]
}

struct ShoppingBackView: View {
    // 전체 선택 체크박스 State 변수
    @State private var isCheckedAll = true
    // 총 배송비
    @State private var shippingCost = 3000
    
    @ObservedObject var vm: ShoppingCartViewModel = ShoppingCartViewModel()
    
    // 결제할 총 금액
    var totalPrice: Int {
        return vm.sCItems
            .filter{ $0.itemIsChecked }
            .map{$0.itemPrice * ($0.itemListCount + 1)} 
            .reduce(0, +)
    }
    // 결제할 총 수량
    var totalCount: Int {
        return vm.sCItems
            .filter{ $0.itemIsChecked }
            .map{$0.itemListCount + 1}
            .reduce(0, +)
    }
    
    var body: some View {
        // MARK: head
        NavigationStack {
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
                        
                        // 선택된 item들 한번에 삭제
                        Button {
                            vm.sCItems.removeAll(where: { $0.itemIsChecked})
                        } label: {
                            Text("선택삭제")
                                .font(.headline)
                        }
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
                        ShoppingBackDetailView(item: item, vm: vm)
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
                            Text("\(totalPrice)원")
                        }
                        HStack {
                            Text("총 배송비")
                            Spacer()
                            Text("+ \(shippingCost)원")
                        }
                        HStack {
                            Text("결제금액")
                            Spacer()
                            Text("\(totalPrice+shippingCost)원")
                        }
                        .font(.title.bold())
                        .padding(.top, 5)

                        HStack {
                            Text("총 수량 : \(totalCount)개")
                                .font(.subheadline)
                            Spacer()
                            
                            // 무통장 구매 view로 이동
                            NavigationLink(destination: {
                                Text("구매")
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxWidth: 200, maxHeight: 50)
                                    Text("바로구매")
                                        .foregroundColor(.white)
                                }
                            })
                            .disabled(totalCount == 0 ? true : false)
                            
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    func checkBoxAll() {
        if isCheckedAll {
            for index in vm.sCItems.indices {
                vm.sCItems[index].itemIsChecked = true
            }
        } else {
            for index in vm.sCItems.indices {
                vm.sCItems[index].itemIsChecked = false
            }
        }
    }
}

struct ShoppingBackView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingBackView()
    }
}
