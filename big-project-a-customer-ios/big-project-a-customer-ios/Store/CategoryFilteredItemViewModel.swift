//
//  CategoryFilteredItemModel.swift
//  big-project-a-customer-ios
//
//  Created by mac on 2023/01/04.
//

import Foundation
import Firebase

class CategoryFilteredItemViewModel:ObservableObject{
    @Published var filteredItemDatas:[ItemInfo]?
    
    let database = Firestore.firestore()
    
    // MARK: - Request ItemDatas in Firestore
    /// Store db에 있는 특정 category를 갖는 아이템 들을 가져옵니다.
    ///  - Parameter category: 품목의 카테고리
    func requestItemDatas(category: String) async{
        var storeDocumentIds:[String] = []
        do{
            let queryResults = try await
            database.collection(AppCategoryEnum.store.rawValue).getDocuments()
            for store in queryResults.documents{
                storeDocumentIds.append(store as! String)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        var fetchingResult: [ItemInfo] = []
        do{
            for store in storeDocumentIds{
                do{
                    let queryResults = try await
                    database.collection(AppCategoryEnum.store.rawValue).document(store).collection("Items").getDocuments().
                }catch{
                    
                }
            }
            
            
        }catch{
            print(error)
        }
    }
}
