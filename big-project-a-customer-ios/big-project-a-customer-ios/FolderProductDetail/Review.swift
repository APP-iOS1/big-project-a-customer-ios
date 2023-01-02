//
//  Review.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import Foundation

struct Review {
    
    var id: String
    var author: String
    var authorImageURL: String
    var reviewImageURL: String
    var rating: Double
    var updatedAt: String // timestamp?
    var createdAt: String // timestamp?
    var content: String
    var option: String
//    var likes: Int
//    var dislikes: Int
    // 좋아요, 싫어요 -> 기능상 빼야 할듯?
}
