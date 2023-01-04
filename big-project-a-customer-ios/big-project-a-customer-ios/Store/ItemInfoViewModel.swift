//
//  ItemInfoViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2023/01/03.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class ItemInfoViewModel: ObservableObject {
    @Published var products: [ItemInfo] = []
    
    let db = Firestore.firestore()
    
    // MARK: Firestore StoreInfo 컬렉션에서 모든 id 값을 저장 한 후 products 배열에 데이터 패치
    func fetchStoreInfo() {
        var storeInfoId: [String] = []
        
        //Firestore StoreInfo 컬렉션에서 모든 id 값을 저장
        db.collection("StoreInfo").getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let id : String = document.documentID
                    storeInfoId.append(id)
                }
                
                // products 배열에 데이터 패치
                self.fetchItemInfo(storeInfoId)
                print(storeInfoId)
            }
        }
    }
    
    func fetchItemInfo(_ storeInfoId: [String]) {
        self.products.removeAll()
        
        for i in storeInfoId {
            db.collection("StoreInfo").document(i).collection("Items").getDocuments{ (snapshot, error) in
                
                if let snapshot {
                    for document in snapshot.documents {
                        
                        let docData = document.data()
                        
                        let id: String = document.documentID
                        let itemName: String = docData["itemName"] as? String ?? ""
                        let itemCategory: String = docData["itemCategory"] as? String ?? ""
                        let itemAmount: String = docData["itemAmount"] as? String ?? ""
                        let itemImage: [String] = docData["itemImage"] as? [String] ?? [""]
                        let price: Double = docData["price"] as? Double ?? 0
                        let itemId: String = docData["itemId"] as? String ?? ""
                        let storeId: String = docData["storeId"] as? String ?? ""
                        let itemAllOption: ItemOptions = docData["itemAllOption"] as? ItemOptions ?? ItemOptions(itemOptions: ["옵션없음" : ["기본옵션_0"]])

                        
                        let product: ItemInfo = ItemInfo(itemId: itemId, storeId: storeId, itemName: itemName, itemCategory: itemCategory, itemAmount: Int(itemAmount) ?? 1, itemAllOption: itemAllOption, itemImage: itemImage, price: price)
                        
                        print("\(product.itemImage)")
                        
                        self.products.append(product)
                    }
                }
            }
        }
    }
    
    struct FilteredItem: Hashable {
        var name: String
        var price: Double
        var image: String
        var itemId: String
        var storeId: String
        var itemAllOption: [String: [String]]
    }
    
    @Published var filteredItem: [FilteredItem] = []
    
    func fliteringCategoryItems(_ category: String) {
        filteredItem.removeAll()
        
        products.forEach { ItemInfo in
            if ItemInfo.itemCategory == category {
                let name: String = ItemInfo.itemName
                let price: Double = ItemInfo.price
                let image: String = ItemInfo.itemImage.first ?? "이미지 x"
                let itemId: String = ItemInfo.itemId
                let storeId: String = ItemInfo.storeId
                let itemAllOption: [String: [String]] = ItemInfo.itemAllOption.itemOptions
                
                filteredItem.append(FilteredItem(name: name, price: price, image: image, itemId: itemId, storeId: storeId, itemAllOption: itemAllOption))
            }
        }
    }
}
