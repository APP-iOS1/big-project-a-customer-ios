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
    
    // MARK: - Create New Customer(user)
    /// Auth에 새로운 사용자를 생성합니다.
    /// - Parameter email: 입력받은 사용자의 email
    /// - Parameter password: 입력받은 사용자의 password
    /// - Parameter nickname: 입력받은 사용자의 nickname
    
    // MARK: - Request ShoppingBag Items
    /// uid 값을 통해 database의 특정 uid에 저장된 장바구니 아이템을 요청합니다.
    /// - Parameter uid: 로그인한 사용자의 uid
    func requestShoppingList(uid: String) async -> Void {
        
        do {
            let snapshot = try await firebasePath.document(uid).collection("MyCart").getDocuments()

            for document in snapshot.documents {
                let requestedData = document.data()
                
                let itemuid: String = requestedData["itemuid"] as? String ?? ""
                let storeId: String = requestedData["storeId"] as? String ?? ""
                let itemName: String = requestedData["itemName"] as? String ?? ""
                let itemImage: String = requestedData["itemImage"] as? String ?? ""
                let price: Int = requestedData["price"] as? Int ?? 0
                let deliveryStatus: DeliveryStatusEnum = requestedData["deliveryStatus"] as? DeliveryStatusEnum ?? .pending
                let option: [String: (String, Int)] = requestedData["option"] as? [String: (String, Int)] ?? [:]
                
                dump("\(itemuid), \(storeId), \(itemName), \(itemImage), \(price), \(deliveryStatus), \(option)")
                
                let orderItem = OrderItemInfo(itemuid: itemuid,
                                              storeId: storeId,
                                              itemName: itemName,
                                              itemImage: itemImage,
                                              price: price,
                                              deliveryStatus: deliveryStatus,
                                              option: option)
                self.items.append(orderItem)
            }
            
        } catch {
            dump("ERROR SHOPPINGBAGS ITEMS REQUEST FALIED : \(error.localizedDescription)")
        }
        
    }
}
