//
//  Bank.swift
//  Payment
//
//  Created by Donghoon Bae on 2022/12/27.
//

import Foundation

// MARK: Bank
/// 은행정보 구조체
/// name: 은행이름
/// account: 은행 계좌번호
/// bankImage: 은행 로고 이미지. (String으로 받아서 Assets으로 처리)
struct Bank: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var account: String
    var bankImage: String
}

// MARK: banks
/// 은행정보는 FireStore에 저장하고, 로그인 시 한 번만 받아옴
/// 현재는 배열로 저장
let banks: [Bank] = [
    Bank(name: "KB국민은행", account: "XXXXXX-XX-XXXXXX", bankImage: "kookminbank"),
    Bank(name: "IBK기업은행", account: "XXX-XXXXXX-XX-XXX", bankImage: "ibkbank"),
    Bank(name: "NH농협은행", account: "XXX-XXXX-XXXX-XX", bankImage: "nhbank"),
    Bank(name: "우리은행", account: "XXXX-XXX-XXXXXX", bankImage: "wooribank"),
    Bank(name: "신한은행", account: "XXX-XXX-XXXXXX", bankImage: "shinhanbank"),
    Bank(name: "카카오뱅크", account: "XXXX-XX-XXXXXXX", bankImage: "kakaobank")
]
