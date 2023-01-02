//
//  Product.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import Foundation

struct ItemJegyun: Identifiable {
    
    var id: String // 제품id
    var storeId: String // 판매자 id
    var itemName: String // 제품명
    var itemImage: [String] // 제품이미지
    var itemCategory: String // 제품카테고리
    var itemAmount: Int // 제품수량
    var options: [String:[String]] // 제품옵션
    var price: Int // 제품가격
    //    var rating: Double
    //    var brand: String
    
}
