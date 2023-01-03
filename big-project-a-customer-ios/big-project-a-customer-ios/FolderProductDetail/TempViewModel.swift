//
//  TempViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/28.
//

import Foundation

class TempViewModel: ObservableObject {
    @Published var options: [String: [(String, Int)]] = [:]
    @Published var selectedPicker: [String] = []
    @Published var selectedOptions: [String: (String, Int)] = [:]
    @Published var basePrice: Int = 50000
    @Published var totalPrice: Int = 0
    @Published var optionPrice: Int = 0
    
    init() {
        self.fetchPostDetail()
    }
    
    func calcTotalPrice() {
        totalPrice = basePrice
        for (_, price) in Array(selectedOptions.values) {
            totalPrice += price
        }
    }
    
    func fetchPostDetail() {
        let optionsGetOnServer: [String: [String]] = [
            "색상" : ["빨강_1000", "파랑_2000", "초록_0"],
            "사이즈" : ["S_0", "M_0", "L_0"]
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
}
