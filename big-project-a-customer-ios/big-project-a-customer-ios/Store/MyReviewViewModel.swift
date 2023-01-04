//
//  MyReviewViewModel.swift
//  big-project-a-customer-ios
//
//  Created by mac on 2023/01/03.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class MyReviewViewModel: ObservableObject {
    @Published var myReviewInfos:[MyReviewInfo]?
    @Published var myReviewItemDatas:[ItemInfo]?
    
    let database = Firestore.firestore()
    
    
    // MARK: - Request MyReview in Firestore
    /// Customer db에 있는 특정 user id의 리뷰들을 가져옵니다.
    /// - Parameter uid: user의 uid
    @MainActor
    func requestMyReviews(uid: String) async {
        var fetchingResult:[MyReviewInfo] = []
        do{
            let documents = try await database.collection(appCategory.rawValue).document(uid).collection("MyReview")
                .getDocuments()
            for document in documents.documents{
                fetchingResult.append(MyReviewInfo(itemID: document["itemID"] as! String, storeID: document["storeID"] as! String))
            }
            self.myReviewInfos = fetchingResult
            print("MyReviewInfos:\(self.myReviewInfos ?? [])")
        }catch{
            print(error)
        }
    }
    
    // MARK: - Request item info i reviewd
    /// 리뷰를 쓴 아이템의 간단한 정보들을 가져옵니다.
    /// - Parameter reviewItemDatas: [MyReviewItemInfo]
    ///
    ///
    @MainActor
    func requestMyReviewDatas(reviewItemDatas: [MyReviewInfo]) async  {
        var fetchingResult:[ItemInfo] = []
        let docRef = database.collection(AppCategoryEnum.store.rawValue)
        
            for data in reviewItemDatas {
                do{
                    let nowItem =  try await docRef.document(data.storeID).collection("Items").document(data.itemID).getDocument(as: ItemInfo.self)
                        fetchingResult.append(nowItem)
                }catch{
                    print("Error in MyReviewViewModel -> requestMyReviewDatas")
                    return
                }
                
            }
        myReviewItemDatas = fetchingResult
        
        print("MyReviewItemDatas:\(self.myReviewItemDatas ?? [])")
        
    }
}
