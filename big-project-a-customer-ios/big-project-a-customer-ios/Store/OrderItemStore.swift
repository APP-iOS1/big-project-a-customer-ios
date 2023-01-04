//
//  OrderItemStore.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2023/01/03.
//

import Foundation
import SwiftUI
import Firebase


class OrderItemStore: ObservableObject {
    @Published var items: [OrderItemInfo] = []
    let firebasePath = Firestore.firestore()
    
    // MARK: - Request ShoppingBag Items
    /// uid 값을 통해 database의 특정 uid에 저장된 장바구니 아이템을 요청합니다.
    /// - Parameter uid: 로그인한 사용자의 uid
    /// - Parameter item: 장바구니에 담을 item 정보
    /// [String: (String, Int)] -> [색상: 노란색_100, 크기: s_2000 ]
    /// [색상: (노란색, 1000), 크기: (s, 2000)]
    func createShoppingItem(uid: String, item: OrderItemInfo) {
        let newOptions: [String: String] = changeOptionsLocalToServer(item.option)
        
        // Document의 id(name)는 상품의 id여야 한다.
        firebasePath.collection("CustomerInfo")
            .document(uid).collection("myCart").addDocument(data: [
                "itemuid": item.itemuid,
                "storeId": item.storeId,
                "itemName": item.itemName,
                "itemImage": item.itemImage,
                "price": item.price,
                "amount": item.amount,
                "deliveryStatus": item.deliveryStatus.rawValue,
                "option": newOptions
            ])
    }
    
    // MARK: - Request ShoppingBag Items
    /// uid 값을 통해 database의 특정 uid에 저장된 장바구니 아이템을 요청합니다.
    /// - Parameter uid: 로그인한 사용자의 uid
    func requestShoppingList(uid: String) async -> Void {
        do {
            let snapshot = try await firebasePath.collection("CustomerInfo").document(uid).collection("MyCart").getDocuments()

            for document in snapshot.documents {
                let requestedData = document.data()
                
                let itemuid: String = requestedData["itemuid"] as? String ?? ""
                let storeId: String = requestedData["storeId"] as? String ?? ""
                let itemName: String = requestedData["itemName"] as? String ?? ""
                let itemImage: String = requestedData["itemImage"] as? String ?? ""
                let price: Int = requestedData["price"] as? Int ?? 0
                let amount: Int = requestedData["amount"] as? Int ?? 0
                // 배송상태가 서버에 열거형의 rawvalue로 저장되기 때문에 열거형 타입으로 변환
                let deliveryStrings = requestedData["deliveryStatus"] as? String ?? "pending"
                let deliveryStatus: DeliveryStatusEnum = DeliveryStatusEnum(rawValue: deliveryStrings) ?? .pending

                let option: [String: String] = requestedData["option"] as? [String: String] ?? [:]
                let newOptions = changeOptionsServerToLocal(option: option)
                
                dump("\(itemuid), \(storeId), \(itemName), \(itemImage), \(price), \(deliveryStatus), \(option)")
                
                let orderItem = OrderItemInfo(itemuid: itemuid,
                                              storeId: storeId,
                                              itemName: itemName,
                                              itemImage: itemImage,
                                              price: price,
                                              amount: amount,
                                              deliveryStatus: deliveryStatus,
                                              option: newOptions)
                
                // Main Thread에서 Published 프로퍼티 변경
                await MainActor.run(body: {
                    self.items.append(orderItem)
                })
                
                print("orderItem: \(orderItem)")
            }
        } catch {
            print("Read Error")
            dump("ERROR SHOPPINGBAGS ITEMS REQUEST FALIED : \(error.localizedDescription)")
        }
    }
    
    // MARK: - 장바구니의 담긴 아이템의 수량을 변경하는 메소드
    /// - Parameter uid: 로그인한 사용자의 uid
    /// - Parameter itemUID: 변경할 아이템의 uid
    /// - Parameter newAmount: 변경할 아이템의 수량
    ///  장바구니에 담긴 아이템의 수량을 변경한다.
    func updateShoppingItem(uid: String, itemUID: String, newAmount: Int) {
        let itemRef = firebasePath.collection("CustomerInfo").document(uid).collection("MyCart").document(itemUID)
        
        itemRef.updateData([
            "amount": newAmount
        ]) 
    }
    
    // MARK: - 장바구니의 담긴 아이템의 삭제하는 메소드
    /// - Parameter uid: 로그인한 사용자의 uid
    /// - Parameter itemUID: 변경할 아이템의 uid
    /// 삭제버튼을 누르거나, 선택 삭제를 누르면 장바구니에 담긴 아이템 삭제를 수행한다.
    func deleteShoppingItem(uid: String, itemUID: String) {
        firebasePath.collection("CustomerInfo").document(uid).collection("MyCart").document(itemUID).delete() { error in
            if let error = error {
                dump("ERROR SHOPPINGBAGS ITEMS REMOVE FALIED : \(error.localizedDescription)")
            } else {
                print("ERROR SHOPPINGBAGS ITEMS REMOVE SUCCESS")
            }
        }
    }
    
    // MARK: - 옵션의 형태를 변환하는 메소드
    /// 서버에 저장된 형태는 [색상: 노란색_100, 크기: s_1000 ]이다.
    /// 그러므로 [String: (String, Int)]형태로 변환하는 작업을 수행해야 한다.
    /// 아래는 변환 작업을 수행함
    func changeOptionsServerToLocal(option: [String: String]) -> [String: (String, Int)] {
        var newOptions: [String: (String, Int)] = [:]
        option.forEach { dict in
            let split = dict.value.components(separatedBy: "_")
            newOptions[dict.key] = (split.first ?? "null", Int(split.last ?? "0") ?? 0)
        }
        return newOptions
    }
    
    // MARK: - 옵션의 형태를 변환하는 메소드
    /// 로컬에 저장된 형태는 ("red", 1000), "size": ("s", 0)이다.
    /// 그러므로 서버에 저장하기 위해서는 ["color": "red_1000", "size": "s_0"]형태로 변환하는 작업을 수행해야 한다.
    /// 아래는 변환 작업을 수행함
    func changeOptionsLocalToServer(_ oldOptions: [String: (String, Int)]) -> [String: String] {
        var newOptions: [String: String] = [:]
        oldOptions.forEach { dict in
            newOptions[dict.key] = "\(dict.value.0)_\(dict.value.1)"
        }
        return newOptions
    }
}
