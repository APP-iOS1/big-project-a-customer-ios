//
//  CustomerServiceInfo.swift
//  big-project-a-customer-ios
//
//  Created by Da Hae Lee on 2023/01/03.
//

import Foundation
import Firebase

final class CustomerServiceStore: ObservableObject {
    @Published var customerService: [CustomerServiceInfo] = []
    
    static var shared: CustomerServiceStore = CustomerServiceStore() // singleton 
    let database = Firestore.firestore()
    
    // FIXME: - item 아이디를 가져오는 매개변수
    /// 매개변수가 현재 item 자체의 id만 가져오는데, View에서 어떤 값을 줄 수 있는지 보고 ItemId로 fix하던지, 아니면 적절하게 만들던지
    // MARK: - Request CustomerService List (QnA)
    /// 사용자가 제품에 남긴 문의 사항과 그에 대한 판매자의 답변을 리스트로 요청합니다.
    /// - Parameter itemId: 선택된 아이템의 고유 id 값
    @MainActor
    func requestCustomerServiceList(itemId: String) async -> Void {
        do {
            let documents = try await database.collection(AppCategoryEnum.cs.rawValue)
                .whereField("itemId", isEqualTo: itemId)
                .getDocuments()
            self.customerService.removeAll()
            for document in documents.documents {
                let id = document.documentID
                let title = document["title"] as? String ?? ""
                let description = document["description"] as? String ?? ""
                let itemId = document["itemId"] as? String ?? ""
                let itemName = document["itemName"] as? String ?? ""
                let itemImage = document["itemImage"] as? Array<String> ?? []
                let serviceDate = document["serviceDate"] as? Timestamp ?? Timestamp(date: Date.now)
                let customerId = document["customerId"] as? String ?? ""
                let orderId = document["orderId"] as? String ?? ""
                let itemAllOption = document["itemAllOption"] as? ItemAllOption
                let isAnswered = document["isAnswered"] as? Bool ?? false
                self.customerService.append(CustomerServiceInfo(id: id, title: title, description: description, itemId: itemId, itemName: itemName, itemImage: itemImage, serviceDate: serviceDate, customerId: customerId, orderId: orderId, itemAllOption: itemAllOption, isAnswered: isAnswered))
            }
            print("\(customerService)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // FIXME: item의 자료형
    /// 매개변수 item의 자료형은 Item Model로 변경해야 합니다.
    /// 또한 item과 User에 대한 값도 받아서 필드 값으로 넣어줘야 합니다.
    // MARK: - Create CustomerService (QnA)
    /// 사용자가 특정 상품에 대해 작성한 문의 글을 서버에 등록합니다.
    /// - Parameters title: customer service title
    /// - Parameters description: customer service description
    /// - Parameters userId: Current usre Id
    func createCustomerService(/* item: Item, */title: String, description: String, userId: String) async -> Void {
        let id = UUID().uuidString
        do {
            try await database.collection(AppCategoryEnum.cs.rawValue)
                .document(id)
                .setData([
                    "id": id,
                    "title": title,
                    "description": description,
                    "itemId": "",
                    "itemName": "",
                    "itemImage": [],
                    "serviceDate": Timestamp(date: Date.now),
                    "customerId": userId,
                    "orderId": "",
                    "itemAllOption": [],
                    "isAnswered": false
                ])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createMyQuestionService(/*item: Item,*/ title: String, description: String, itemImage:[String], itemName:String, orderId : String, userId: String) async -> Void {
        let id = UUID().uuidString
        do {
            try await database.collection(AppCategoryEnum.cs.rawValue)
                .document(id)
                .setData([
                    "id": id,
                    "title": title,
                    "description": description,
                    "itemId": "",
                    "itemName": itemName,
                    "itemImage": itemImage,
                    "serviceDate": Timestamp(date: Date.now),
                    "customerId": userId,
                    "orderId": orderId,
                    "itemAllOption": [],
                    "isAnswered": false
                ])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Delete CustomerService (QnA)
    func deleteCustomerService() {
        
    }
}
