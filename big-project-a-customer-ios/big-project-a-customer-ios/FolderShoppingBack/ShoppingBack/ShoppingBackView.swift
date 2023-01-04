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
    var name: String
    var price: Int
    var image: String
    var amount: Int
    var isChecked: Bool
    // [옵션 이름: (옵션 값, 추가 가격)]
    var options: [String: (String, Int)]
}

// MARK: - 임시 장바구니 뷰 모델
/// 장바구니에 담긴 item들을 가지고 있음
class ShoppingCartViewModel: ObservableObject {
    // ShoppingCartItems 약자
    @Published var sCItems: [ShoppingCartItems] = [
        ShoppingCartItems(name: "MacBook Pro", price: 2060000,image: "macbookpro", amount: 0,isChecked: false, options: ["색상" : ("스페이스 그레이", 0), "저장용량" : ("512GB", 0), "RAM" : ("8GB", 0)]),
        ShoppingCartItems(name: "MacBook Air", price: 1690000,image: "macbookair", amount: 0 ,isChecked: false, options: ["색상" : ("실버", 0), "저장용량" : ("1024GB", 300000), "RAM" : ("16GB", 200000)]),
        ShoppingCartItems(name: "iphone14", price: 1550000,image: "iphone14", amount: 0, isChecked: false, options: ["색상" : ("딥 퍼플", 0), "저장용량" : ("128GB", 0)])
    ]
    // MARK: - 장바구니에 아이템을 추가하는 메소드
    /// 파라미터로 ShoppingCartItems 인스턴스를 전달하면 됩니다
    /// ex) ShoppingCartItems(name: "MacBook Pro", price: 2060000,image: "macbookpro", amount: 0, isChecked: true, options: ["색상" : ("스페이스 그레이", 0), "저장용량" : ("512GB", 0), "RAM" : ("8GB", 0)])
    func addItemToShoppingCart(_ item: ShoppingCartItems) {
        sCItems.append(item)
    }
    
    // 장바구니에 아이템을 삭제하는 메소드
    func deleteItem(_ item: ShoppingCartItems) {
        let index = sCItems.firstIndex {
            $0.id == item.id
        }
        sCItems.remove(at: index!)
    }
    
    // 장바구니에서 선택된 아이템을 삭제하는 메소드
    func clearSelectedShoppingCart() {
        sCItems.removeAll(where: { $0.isChecked})
    }
}


struct ShoppingBackView: View {
    // 전체 선택 체크박스 State 변수
    @State private var isCheckedAll = false
    // 총 배송비
    @State private var shippingCost = 3000
    
//    @ObservedObject var vm: ShoppingCartViewModel = ShoppingCartViewModel()
    
    @EnvironmentObject var shoppingStores: OrderItemStore
    
    @State var totalPriceForBinding = 0
    
    @State var isShowingLoginSheet = false
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    @State var checkDict: [String:Bool] = [:]
    
    // 결제할 총 금액
    var totalPrice: Int {
//        return vm.sCItems
//            .filter{ $0.isChecked }
//            .map{$0.price * ($0.amount + 1) + ($0.options).values.map{$0.1}.reduce(0,+) }
//            .reduce(0, +)
        return shoppingStores.items
            .map { ($0.price * $0.amount) + ($0.option).values.map { $0.1 }.reduce(0, +) }
            .reduce(0, +)
    }
    
    // 결제할 총 수량
    var totalCount: Int {
//        return vm.sCItems
//            .filter{ $0.isChecked }
//            .map{$0.amount + 1}
//            .reduce(0, +)
        
        return shoppingStores.items
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var body: some View {
        // MARK: head
        NavigationStack {
            Spacer().frame(height:30)
            VStack {
                Section {
                    HStack {
                        Button {
                            isCheckedAll.toggle()
                            checkBoxAll()
                        } label: {
                            Image(systemName: isCheckedAll ? "checkmark.square.fill" : "square")
                                .modifier(CheckBoxModifier(isCheckedAll: isCheckedAll))
                        }
                        
                        Text("모두선택")
                            .font(.headline)
                        
                        Text("\(totalCount)/\(shoppingStores.items.count)")
                        
                        Spacer()
                        
                        // 선택된 item들 한번에 삭제
                        Button {
                             removeAll()
                            
//                            vm.sCItems.removeAll(where: { $0.isChecked})
                        } label: {
                            Text("선택삭제")
                                .font(.headline)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 1)
                
                Divider()
                    .frame(minHeight: 3)
                    .overlay(Color.gray.brightness(0.3))
                
                Spacer()
                
                // FIXME: 민주님 확인 부탁들입니다!!
                // 로그인에 성공하면 userEmail이 nil이 아니므로 OrderSheetAddress뷰로 이동한다.
                if signUpViewModel.currentUser?.userEmail != nil {
                    // MARK: body
                    ScrollView(showsIndicators: false) {
                        ForEach($shoppingStores.items, id: \.itemuid) { item in
//                            ShoppingBackDetailView(item: item, vm: shoppingStores, checkDict: $checkDict)
                            ShoppingBackDetailView(item: item, checkDict: $checkDict)
                                .padding(.vertical)
                            
                            Divider()
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: tail
                    Section {
                        VStack {
                            HStack {
                                Text("총 상품 금액")
                                Spacer()
                                Text("\(totalPrice)원")
                            }
                            HStack {
                                Text("총 배송비")
                                Spacer()
                                Text("+ \(totalPrice == 0 ? 0 : shippingCost)원")
                            }
                            Divider()
                            HStack {
                                Text("결제 금액")
                                Spacer()
                                Text("\(totalPrice == 0 ? 0 : totalPrice+shippingCost)원")
                            }
                            .font(.title2.bold())
                            
                            HStack {
                                NavigationLink(destination: {
                                    OrderSheetAddress(totalPriceForBinding: $totalPriceForBinding)
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                        Text("구매하기 (\(totalCount))")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                    }
                                    
                                }
                                               
                                )
                                
                                
                                
                            }
                        }
                    }
                    .padding()
                    .background {
                        Color.gray.brightness(0.4)
                    }
                    .sheet(isPresented: $isShowingLoginSheet) {
                        LoginView()
                    }
                }else { // userEmail이 nil이면 로그인을 하지 않은 상태이므로 LoginView를 띄운다.
                    Button {
                        isShowingLoginSheet.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 200, maxHeight: 50)
                            Text("바로구매")
                                .foregroundColor(.white)
                        }
                        
                        
                        HStack {
                            
                            // 로그인에 성공하면 userEmail이 nil이 아니므로 OrderSheetAddress뷰로 이동한다.
                            if signUpViewModel.currentUser?.userEmail != nil {
                                NavigationLink(destination: {
                                    OrderSheetAddress(totalPriceForBinding: $totalPriceForBinding)
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                        Text("구매하기 (\(totalCount))")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                    }
                                })
                                .disabled(totalCount == 0 ? true : false)
                                .simultaneousGesture(TapGesture().onEnded{
                                    totalPriceForBinding = totalPrice
                                })
                            } else { // userEmail이 nil이면 로그인을 하지 않은 상태이므로 LoginView를 띄운다.
                                Button {
                                    isShowingLoginSheet.toggle()
                                    
                                    
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                        Text("구매하기 (\(totalCount))")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            } // if - else
                            
                        } // HStack
                        
                    }
                    .modifier(PurchaseSectionModifier())
                }
                
            }
            .fullScreenCover(isPresented: $isShowingLoginSheet) {
                LoginView()
                    .onDisappear {
                        Task {
                            await fetchData()
                            
//                            shoppingStores.updateShoppingItem(uid: signUpViewModel.currentUser?.id ?? "", itemUID: "7fEFIEBtfZxUGuskuLwg", newAmount: 2)
                        }
                    }
            }
            .navigationBarTitle("장바구니")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear {
                print("ShoppingBag Appear 호출")
                guard signUpViewModel.currentUser != nil else {
                    return
                }
                Task {
                    await fetchData()
                }
            }
        }
    }
    
    func fetchData() async {
        await shoppingStores.requestShoppingList(uid: signUpViewModel.currentUser?.id ?? "")
        
        for item in shoppingStores.items {
            checkDict[item.itemuid] = false
        }
    }
    
    // 체크박스된 장바구니 모두 제거
    func removeAll() {
        for (key, value) in checkDict {
            if value {
                shoppingStores.deleteShoppingItem(uid: signUpViewModel.currentUser?.id ?? "", itemUID: key)
            }
        }
    }
    
    func checkBoxAll() {
//        if isCheckedAll {
//            for index in vm.sCItems.indices {
//                vm.sCItems[index].isChecked = true
//            }
//        } else {
//            for index in vm.sCItems.indices {
//                vm.sCItems[index].isChecked = false
//            }
//        }
        
        if isCheckedAll {
            for (key, _) in checkDict {
                checkDict[key] = true
            }
        } else {
            for (key, _) in checkDict {
                checkDict[key] = false
            }
        }
    }
}

struct ShoppingBackView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingBackView()
    }
}
