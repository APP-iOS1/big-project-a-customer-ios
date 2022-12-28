//
//  UserModel.swift
//  big-project-a-customer-ios
//
//  Created by TAEHYOUNG KIM on 2022/12/27.
//

import Foundation

struct MyPageUserModel {
    var id: String
    var name: String
    var nickName: String
    var userEmail: String
    var userPassward: String
    var userAddress: String
    var phoneNumber: String
    var userProfileImage: String
}

class MyPageViewModel: ObservableObject {
    @Published var users: MyPageUserModel
    
    init() {
        users = MyPageUserModel(id: UUID().uuidString, name: "홍길동", nickName: "홍형", userEmail: "yahoth@naver.com", userPassward: "1234", userAddress: "서울특별시 A대로 100번지", phoneNumber: "010-1234-1234", userProfileImage: "")
    }
}
