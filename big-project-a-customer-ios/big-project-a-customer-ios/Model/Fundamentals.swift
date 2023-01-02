//
//  Fundatmentals.swift
//  BigprojectAServer
//
//  Created by 이승준 on 2022/12/29.
//

import Foundation

let appCategory: AppCategoryEnum = .customer

// MARK: - 앱의 성격을 구별하는 카테고리 열거형
/// 사용자가 현재 사용 중인 프로젝트의 앱을 구별하는 열거형입니다.
/// - 현재 앱에서는 판매자용 iPad 앱임을 나타내기 위해 전역 상수로 .store 가 할당되어 있습니다.
/// - 해당 열거형의 원시값을 활용하여 Firebase의 콜렉션에 접근합니다.
enum AppCategoryEnum: String, Codable {
    case customer = "CustomerInfo", store = "StoreInfo", backoffice = "AdminInfo"
}
