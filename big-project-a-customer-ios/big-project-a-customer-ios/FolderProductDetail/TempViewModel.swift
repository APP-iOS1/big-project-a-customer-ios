//
//  TempViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/28.
//

import Foundation

import FirebaseFirestore

// 
class TempViewModel: ObservableObject {

    // 받아온 상품 데이터는 ProductDetail에 존재한다
    // productDetailView에 onAppear될때 basePrice 세팅해주기, 받은 상품정보 넣어서 fetch

    // 제품에서 받아와서 세팅해준 옵션,,>?
    @Published var options: [String: [(String, Int)]] = [:]
    @Published var selectedPicker: [String] = []
    @Published var selectedOptions: [String: (String, Int)] = [:]
    @Published var basePrice: Int = 50000
    @Published var totalPrice: Int = 0

    let tempUserId = "qYhUKe7w4OZVPD1jxVUPk5bqRb53"
    let database = Firestore.firestore()

    // 옵션을 선택했을 때 총 가격을 계산하는 메서드
    func calcTotalPrice() {
        totalPrice = basePrice

        for (_, price) in Array(selectedOptions.values) {
            totalPrice += price
        }
    }

    // productDetailView에서 받은 상품정보 넣어서 fetch
    func fetchPostDetail(_ productOptions: [String: [String]]) {

            for key in productOptions.keys {
                for value in productOptions[key, default: []] { // value -> 빨강_1000, 파랑_2000, 초록_0
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

    }
