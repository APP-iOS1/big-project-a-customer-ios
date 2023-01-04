//
//  OrderStore.swift
//  big-project-a-customer-ios
//
//  Created by Da Hae Lee on 2023/01/04.
//

import Foundation
import Firebase

final class OrderStore: ObservableObject {
    @Published var order: OrderInfo = OrderInfo(orderId: "", orderedUserInfo: "", orderTime: 0, orderedItems: [], orderAddress: "", orderMessage: "", payment: .byCreditCard)
    
    let database = Firestore.firestore()
    
    // MARK: - Order Items
    /// 사용자가 요청한 아이템들의 주문을 진행합니다.
    /// - Parameters currentUserUid: 현재 로그인한 유저의 id
    /// - Parameters address: 주문건의 배송지
    /// - Parameters payment: 주문 결제 방법
    /// - Parameters orderItems: 주문건에 포함된 주문 아이템들
    func createOrderItems(currentUserUid: String, address: String, payment: PaymentEnum, orderItems: [OrderItemInfo]) async -> Void {
        let id = UUID().uuidString
        do {
            try await database.collection(appCategory.rawValue)
                .document(currentUserUid)
                .collection("OrderInfo")
                .document(id)
                .setData([
                    "orderId": id,
                    "orderedUserInfo": currentUserUid,
                    "orderTime": Timestamp(date: Date.now),
                    "orderedItems": orderItems,
                    "orderAddress": address,
                    "orderMessage": "",
                    "payment": payment.rawValue
                ])
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    public func createOrderedItemInfo(with currentUserUid: String?,
                                      in currentStoreUserUid: String?,
                                      withItem item: ItemInfo...) async -> Void {
        guard let currentStoreUserUid, let currentUserUid else { return }
        
        // 주문한 아이템의 정보를 담는 배열
        var orderedItemsArray: [OrderedItemInfo] = []
        
        for orderedItem in item {
            let orderedItemsInfo = OrderedItemInfo(itemUid: orderedItem.itemUid, itemName: orderedItem.itemName, itemImage: orderedItem.itemImage, price: orderedItem.price, option: orderedItem.itemAllOption, deliveryStatus: "배송준비중")
            orderedItemsArray.append(orderedItemsInfo)
        }
        
        // 주문 정보 생성
        let newOrderInfo = OrderInfo(orderId: UUID().uuidString, orderedUserInfo: currentUserUid, orderTime: Date.getKoreanNowTimeString(), orderedItems: orderedItemsArray, orderAddress: "배송주소", payment: "무통장입금")
        
        do {
            for orderdItemInfo in orderedItemsArray {
                let path = path.document(currentStoreUserUid)
                    .collection("Items").document(orderdItemInfo.itemUid) // 서로 다른 아이템 id에 하나의 주문 건 아이디만 넣어주기
                    .collection("OrderedInfo").document(newOrderInfo.orderId) // 주문 건 아이디는 유지
                
                // 안에 주문정보 채우기
                try await path.setData([
                    :
                ])
            }
        } catch {
            dump("\(#function) - DEBUG \(error.localizedDescription)")
        }
        
    }
}
