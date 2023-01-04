//
//  ItemInfo.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2023/01/03.
//

import Foundation

struct ItemInfo: Codable {
    var itemUid: String
    var storeId: String
    var itemName: String
    var itemCategory: String
    var itemAmount: Int
    var itemAllOption: ItemOptions
    var itemImage: [String]
    var price: Double
}
