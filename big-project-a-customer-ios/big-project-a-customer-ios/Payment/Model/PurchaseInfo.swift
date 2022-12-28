//
//  PurchaseInfo.swift
//  Payment
//
//  Created by 박성민 on 2022/12/28.
//

import Foundation

// MARK: PurchaseInfo
/// 소비자 정보입니다.
struct PurchaseInfo {
    ///유저 아이디
    var id: String
    
    ///유저 이름
    var userName: String

    ///유저 핸드폰번호
    var userPhoneNumber: String

    ///입금자 이름
    var depositorName: String

    ///받는사람 정보
    var recipient: Recipient

    ///장바구니
    var marketBasket: MarketBasket

    ///총 결제금액
    var payment: String

    ///현금영수증
    var cashReceipt : CashReceipt
    
    ///은행이름
    var bankName : String
    
}

// MARK: Recipient
/// 입력한 배송지 정보입니다.
struct Recipient {
    ///받는사람 이름
    var name: String

    ///받는사람 핸드폰번호
    var phoneNumber: String

    ///받는사람 주소
    var adress: String

    ///받는사람 요청사항
    var requestedTerm: String
}

// MARK: MarketBasket
/// 소비자의 장바구니 정보입니다.
struct MarketBasket {
    ///장바구니 아이디
    var id: String
    
    ///장바구니 상품들
    
    var basketProducts: [String]
    
}

// MARK: CashReceipt
/// 현금영수증 정보입니다.

struct CashReceipt {
    
    var id: String
    
    ///소득공제정보
    var incomDeduction: String
    
    ///현금영수증 번호
    var cashReceiptNumber: String
    
    
}
