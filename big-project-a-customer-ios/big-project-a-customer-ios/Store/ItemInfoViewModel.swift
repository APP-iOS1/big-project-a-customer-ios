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
            db.collection("StoreInfo").document(i).collection("Item").getDocuments{ (snapshot, error) in
                
                if let snapshot {
                    for document in snapshot.documents {
                        
                        let docData = document.data()
                        
                        let id: String = document.documentID
                        let itemName: String = docData["itemName"] as? String ?? "Mac"
                        let itemCategory: String = docData["itemCategory"] as? String ?? "NoteBook"
                        let itemAmount: String = docData["itemAmount"] as? String ?? "0"
                        let itemImage: [String] = docData["itemImage"] as? [String] ?? [""]
                        let price: String = docData["price"] as? String ?? "0"
                        
                        let product: ItemInfo = ItemInfo(itemUid: id, storeId: "", itemName: itemName, itemCategory: itemCategory, itemAmount: Int(itemAmount) ?? 0, itemAllOption: ItemOptions(itemOptions: ["":[""]]), itemImage: itemImage, price: Double(price) ?? 0)
                        
                        print("\(product.itemCategory)")
                        
                        self.products.append(product)
                    }
                }
            }
        }
    }
}
