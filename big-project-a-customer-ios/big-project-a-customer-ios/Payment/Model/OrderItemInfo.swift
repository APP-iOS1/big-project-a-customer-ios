//
//  OrderItemInfo.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2023/01/03.
//

import Foundation

/// MARK: PurchaseInfo
///// 소비자 정보입니다.
//struct PurchaseInfo {
//    ///유저 아이디
//    var id: String
//
//    ///유저 이름
//    var userName: String
//
//    ///유저 핸드폰번호
//    var userPhoneNumber: String
//
//    ///입금자 이름
//    var depositorName: String
//
//    ///받는사람 정보
//    var recipient: Recipient
//
//    ///장바구니
//    var marketBasket: MarketBasket
//
//    ///총 결제금액
//    var payment: String
//
//    ///현금영수증
//    var cashReceipt : CashReceipt
//
//    ///은행이름
//    var bankName : String
//
//}

// MARK: OrderItemInfo
/// 장바구니 아이템 정보입니다

struct OrderItemInfo {
    var itemuid: String
    var storeId: String
    var itemName: String
    var itemImage: String
    var price: Int
    var deliveryStatus: DeliveryStatusEnum
    var option: [String: (String, Int)]
}
