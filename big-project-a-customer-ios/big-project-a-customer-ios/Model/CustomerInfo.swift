//
//  CustomerInfo.swift
//  big-project-a-customer-ios
//
//  Created by Da Hae Lee on 2022/12/28.
//

import Foundation

struct CustomerInfo {
    var id: String = UUID().uuidString
    var userEmail: String
    var userNickname: String
    var userName: String?
    var userAddress: String?
    var phoneNumber: String?
    var birthDate: Date?
    var userProfileImage: String?
}
