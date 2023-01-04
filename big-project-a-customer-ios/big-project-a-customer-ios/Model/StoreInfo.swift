import Foundation

struct StoreInfo: Codable {
    var storeId: String // 회원가입 시점에 생성되는 uid를 할당합니다.
    var storeName: String
    var storeEmail: String
    var storeLocation: String
    var registerDate: String // Timestamp Extension 메소드로 리턴받은 String을 할당합니다.
    var reportingCount: Int
    var storeImage: String?
    var phoneNumber: String
    var isVerified: Bool = false // 입점 허가 여부
    var isSubmitted: Bool = false
    var isBanned: Bool = false // 신고 누적으로 인한 퇴출 여부
}
