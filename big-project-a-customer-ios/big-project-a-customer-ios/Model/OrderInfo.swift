//
//  OrderInfo.swift
//  big-project-a-customer-ios
//
//  Created by Da Hae Lee on 2023/01/03.
//

import Foundation
import Firebase

struct OrderInfo: Codable {
    var orderId: String = UUID().uuidString
    var orderedUserInfo: String
    var orderTime: Timestamp
    var orderedItems: [OrderedItemInfo]
    var orderAddress: String
    var orderMessage: String?
    var payment: PaymentEnum = .byCreditCard
}

struct OrderedItemInfo: Codable {
    var itemUid: String
    var itemName: String
    var itemImage: [String]
    var price: Double
    var option: ItemOptions
    var deliveryStatus: DeliveryStatusEnum = .pending
}

enum DeliveryStatusEnum: String, Codable {
    case beforePurchase = "구매전"
    case pending = "배송준비중"
    case onDeliverying = "배송중"
    case didDelivered = "배송완료"
    case reviewable = "리뷰작성 가능"
    case reviewed = "리뷰작성 완료"
}

enum PaymentEnum: String, Codable {
    case byCreditCard = "카드결제", byAccount = "무통장입금", byMobile = "핸드폰결제"
}
