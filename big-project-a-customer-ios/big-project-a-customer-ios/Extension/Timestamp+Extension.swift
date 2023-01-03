//
//  Timestamp+Extension.swift
//  big-project-a-customer-ios
//
//  Created by Da Hae Lee on 2023/01/03.
//

import Foundation
import Firebase

extension Timestamp {
    /// Timestamp로 날짜를 받아올 때, 날짜를 한국식 날짜로 받아오는 함수 입니다.
    /// 타임스탬프의 인스턴스(fetch된 데이터)에서 호출합니다.
    /// 리턴할 때는 String 타입으로 리턴합니다.
    public func formattedKoreanTime() -> String {
        let date = self.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
