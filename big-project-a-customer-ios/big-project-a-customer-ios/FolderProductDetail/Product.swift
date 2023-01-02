//
//  Product.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import Foundation

struct Product {
    
    var id: String
    var name: String
    var image: String
    //    var reviews: [Review]
    // 문의?? -> 제품별 관리 or 스토어쪽에서 따로 관리?
    var rating: Double
    var options: [String:[String]]
    var category: String
    var brand: String
    var price: Int
    
}
