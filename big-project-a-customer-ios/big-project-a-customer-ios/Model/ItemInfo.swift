import Foundation

struct ItemInfo: Codable {
    var itemId: String?
    //var itemAllOption: ItemOptions
    var itemAmount: Int?
    var itemCategory: String?
    var itemImage: [String]?
    var itemName: String?
    var price: Int?
    var storeId: String?
}

// MARK: - ItemOptions 커스텀 타입
/// 판매자가 아이템의 옵션을 직접 추가할 수 있도록 준비된 커스텀 타입입니다.
/// 사용자가 좌측에 입력한 키(key)가 Firebase 문서에 없다면, 자동으로 해당 데이터를 업데이트 합니다.
/// 모든 키의 밸류(value)는 배열로 업데이트 됩니다.
struct ItemOptions: Codable {
    var itemOptions: [String: [String]]
}
