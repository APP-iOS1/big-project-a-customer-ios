//
//  TempViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/28.
//

import Foundation

import FirebaseFirestore

class TempViewModel: ObservableObject {
    @Published var options: [String: [(String, Int)]] = [:]
    @Published var selectedPicker: [String] = []
    @Published var selectedOptions: [String: (String, Int)] = [:]
    @Published var basePrice: Int = 50000
    @Published var totalPrice: Int = 0
    @Published var optionPrice: Int = 0

    let tempUserId = "qYhUKe7w4OZVPD1jxVUPk5bqRb53"
    let database = Firestore.firestore()

    var isSelectedOptionsEmpty: Bool {
        selectedOptions.isEmpty
    }
    
    init() {
        self.fetchPostDetail()
    }

    // 옵션을 선택했을 때 총 가격을 계산하는 메서드
    func calcTotalPrice() {
        totalPrice = basePrice

        for (_, price) in Array(selectedOptions.values) {
            totalPrice += price
        }
    }

    // 서버에서 옵션을 가져오는 메서드
    // FIXME: - 임시로 구현
    func fetchPostDetail() {
        let optionsGetOnServer: [String: [String]] = [
            "색상": ["빨강_1000", "파랑_2000", "초록_0"],
            "사이즈": ["S_0", "M_0", "L_0"]
        ]

        for key in optionsGetOnServer.keys {
            // FIXME: - default 구문 적용안됨
            for value in optionsGetOnServer[key, default: []] { // value -> 빨강_1000, 파랑_2000, 초록_0
                let newValue = value.split(separator: "_").map { String($0) }

                if options[key] == nil {
                    options[key] = []
                }

                // 반복문을 통해 접근할 때 key로 접근하므로 강제 언래핑이 가능
                options[key]!.append((newValue[0], Int(newValue[1])!))
            }
        }

        // 사용자가 선택한 옵션을 저장하기 위한 프로퍼티를 초기화
        selectedPicker = [String](repeating: "", count: options.count)
    }
    
    
    
    /**
     장바구니에 물건을 담는 메서드
     
     - author: 제균
     
     - Parameter orderItemInfo: OrderItemInfo 구조체를 초기화하여 전달합니다.
     
     */
    func addToCart(_ orderItemInfo: OrderInfo) {
        database.collection("CustomerInfo")
            .document(tempUserId)
            .collection("myCart") // 내 장바구니

            .addDocument(data: [
                "itemuid": orderItemInfo.id,
                "storeId": "당근마켓",
                "imageName": orderItemInfo.itemImage,
                "price": orderItemInfo.price,
                "deliveryStatus": orderItemInfo.deliveryStatusText,
                "option": "옵션"
            ])
        // 제품 id
        // 판매 스토어 id
        // itemName
        // itemImage
        // price
        // deliveryStatus
        // option
    }
}
