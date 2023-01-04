//
//  OrderItemInfo.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2023/01/03.
//

import Foundation

// MARK: OrderItemInfo
/// 장바구니 아이템 정보입니다

struct OrderItemInfo {
    var itemuid: String
    var storeId: String
    var itemName: String
    var itemImage: String
    var price: Int
    var amount: Int
    var deliveryStatus: DeliveryStatusEnum
    var option: [String: (String, Int)]
}
