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
    
    // MARK: - Create CustomerService (QnA)
    func createCustomerService() async -> Void {
        do {
            
        } catch {
            
        }
    }
    
    // MARK: - Delete CustomerService (QnA)
    func deleteCustomerService() {
        
    }
}
