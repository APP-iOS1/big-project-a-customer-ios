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
    func createShoppingItem(uid: String, item: OrderItemInfo) {
        
        firebasePath.document(uid).collection("MyCart").addDocument(data: [
            "itemuid": item.itemuid,
            "storeId": item.storeId,
            "itemName": item.itemName,
            "itemImage": item.itemImage,
            "price": item.price,
            "deliveryStatus": item.deliveryStatus.rawValue,
            "option": item.option
        ])
    }
    
    
    // MARK: - Request ShoppingBag Items
    /// uid 값을 통해 database의 특정 uid에 저장된 장바구니 아이템을 요청합니다.
    /// - Parameter uid: 로그인한 사용자의 uid
    func requestShoppingList(uid: String) async -> Void {
        do {"C"
            let snapshot = try await firebasePath.collection("CustomerInfo").document(uid).collection("MyCart").getDocuments()

            for document in snapshot.documents {
                let requestedData = document.data()
                
                let itemuid: String = requestedData["itemuid"] as? String ?? ""
                let storeId: String = requestedData["storeId"] as? String ?? ""
                let itemName: String = requestedData["itemName"] as? String ?? ""
                let itemImage: String = requestedData["itemImage"] as? String ?? ""
                let price: Int = requestedData["price"] as? Int ?? 0
                // 배송상태가 서버에 열거형의 rawvalue로 저장되기 때문에 열거형 타입으로 변환
                let deliveryStrings = requestedData["deliveryStatus"] as? String ?? "pending"
                let deliveryStatus: DeliveryStatusEnum = DeliveryStatusEnum(rawValue: deliveryStrings) ?? .pending

                let option: [String: String] = requestedData["option"] as? [String: String] ?? [:]
                let newOptions = changeOptionsForm(option: option)
                
                dump("\(itemuid), \(storeId), \(itemName), \(itemImage), \(price), \(deliveryStatus), \(option)")
                
                let orderItem = OrderItemInfo(itemuid: itemuid,
                                              storeId: storeId,
                                              itemName: itemName,
                                              itemImage: itemImage,
                                              price: price,
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
    
    // MARK: - 옵션의 형태를 변환하는 메소드
    /// 서버에 저장된 형태는 [색상: 노란색_100, 크기: s_1000 ]이다.
    /// 그러므로 [String: (String, Int)]형태로 변환하는 작업을 수행해야 한다.
    /// 아래는 변환 작업을 수행함
    func changeOptionsForm(option: [String: String]) -> [String: (String, Int)] {
        var newOptions: [String: (String, Int)] = [:]
        option.forEach { dict in
            let split = dict.value.components(separatedBy: "_")
            newOptions[dict.key] = (split.first ?? "null", Int(split.last ?? "0") ?? 0)
        }
        
        return newOptions
    }
}
