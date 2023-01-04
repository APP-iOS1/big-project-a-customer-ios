//
//  TestViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 지정훈 on 2023/01/03.
//

import Foundation
import Firebase

class TestViewModel : ObservableObject{
    @Published var testData : [TestModel] = []
    
    init(){
        testData = []
    }
    let database = Firestore.firestore()
    
    var arr : [String] = []
    func fetchUserIdSearch(){
        database.collection("CustomerInfo").getDocuments { (snapshot , error) in
            if let snapshot{
                for document in snapshot.documents{
                    let id : String = document.documentID
                    self.arr.append(id)
                }
            }
        }
        
    }
    func fetchUserEqualId(currentUserUid: String){
        fetchUserIdSearch()
        for i in arr {
            database.collection("CustomerInfo").document(i).getDocument { (snapshot,error) in
                if let snapshot{
                    let docData = snapshot.data()
                    let userID : String = docData?["id"] as? String ?? ""
                    if userID == currentUserUid{
                        print("find@@")
                    }
                }
            }
        }
        
    }
    func fetchUserWantProduct(currentUserUid: String){
        database.collection("CustomerInfo").document(currentUserUid).collection("WantProduct").getDocuments { (snapshot,error) in
            if let snapshot{
                for document in snapshot.documents{
                    let docData = document.data()
                    //                    print(docData)
                    let itemID : String = docData["itemID"] as? String ?? ""
                    let storeID : String = docData["storeID"] as? String ?? ""
                    self.testData.append(TestModel(itemID: itemID, storeID: storeID))
                    
                    //                let docData = snapshot.data()
                    //                print(docData)
                }
            }
            print(self.testData)
        }
    }
    
}


