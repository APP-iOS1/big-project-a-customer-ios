import Foundation
import Firebase

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

class SignUpViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var currentUser: CustomerInfo?
    
    let database = Firestore.firestore()
    let authentification = Auth.auth()
    
    
    // MARK: - Create New Customer(user)
    /// Auth에 새로운 사용자를 생성합니다.
    /// - Parameter email: 입력받은 사용자의 email
    /// - Parameter password: 입력받은 사용자의 password
    /// - Parameter nickname: 입력받은 사용자의 nickname
    @MainActor
    func createUser(email: String, password: String, nickname: String) async -> Bool {
        authenticationState = .authenticating
        do  {
            try await authentification.createUser(withEmail: email, password: password)
            print("account created.")
            errorMessage = ""
            authenticationState = .authenticated
            // firestore에 user 등록
            let currentUserId = authentification.currentUser?.uid ?? ""
            registerUser(uid: currentUserId, email: email, nickname: nickname)
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    // MARK: - Register Customer(user) in Firestore
    /// Auth에 새롭게 만든 사용자 정보를 Firestore에 등록합니다.
    /// - Parameter uid: 현재 사용자의 Auth uid
    /// - Parameter email: 현재 사용자의 email
    /// - Parameter nickname: 현재 사용자의 nickname
    func registerUser(uid: String, email: String, nickname: String) {
        database.collection("\(appCategory.rawValue)")
            .document(uid)
            .setData([
                "id" : uid,
                "userEmail" : email,
                "userNickname" : nickname
            ])
    }
    
    // MARK: - 이메일 중복 검사
    /// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 이메일이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
    /// - Parameter currentUserEmail: 입력받은 사용자 이메일
    /// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
    func isEmailDuplicated(currentUserEmail: String) async -> Bool {
        do {
            let document = try await database.collection("\(appCategory.rawValue)")
                .whereField("userEmail", isEqualTo: currentUserEmail)
                .getDocuments()
            return !(document.isEmpty)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: - 닉네임 중복 검사
    /// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
    /// - Parameter currentUserNickname: 입력받은 사용자 닉네임
    /// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
    func isNicknameDuplicated(currentUserNickname: String) async -> Bool {
        do {
            let document = try await database.collection("\(appCategory.rawValue)")
                .whereField("userNickname", isEqualTo: currentUserNickname)
                .getDocuments()
            return !(document.isEmpty)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: - User Login
    /// 사용자의 이메일과 패스워드를 받아 로그인을 요청합니다.
    /// - Parameter email: 입력받은 사용자 email
    /// - Parameter password: 입력받은 사용자 비밀번호
    public func requestUserLogin(withEmail email: String, withPassword password: String) async -> Void {
        do {
            try await authentification.signIn(withEmail: email, password: password)
            // 현재 로그인 한 유저의 정보 담아주는 코드
            // 변경이 필요함!
            let userNickname = await requestUserNickname(uid: authentification.currentUser?.uid ?? "")
            DispatchQueue.main.async {
                self.currentUser = CustomerInfo(id: self.authentification.currentUser?.uid ?? "", userEmail: email, userNickname: userNickname )
            }
                print("userNickname: \(userNickname)")
            
        } catch {
            dump("DEBUG : LOGIN FAILED \(error.localizedDescription)")
        }
    }
    
    // MARK: - User Logout
    /// 로그인한 사용자의 로그아웃을 요청합니다.
    public func requestUserSignOut() {
        do {
            try authentification.signOut()
        } catch {
            dump("DEBUG : LOG OUT FAILED \(error.localizedDescription)")
        }
    }
    
    // MARK: - request Nickname
    /// uid 값을 통해 database의 특정 uid에 저장된 userNickname을 요청합니다.
    ///  - Parameter uid : currentUser의 UID
    ///  - Returns : currentUser의 userNickname
    private func requestUserNickname(uid: String) async -> String {
        var retValue = ""
//        print("requestUserNickname 1")
        return await withCheckedContinuation({ continuation in
            database.collection(appCategory.rawValue).document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    retValue = document.get("userNickname") as! String
//                    print("requestUserNickname 2: \(retValue)")
                    continuation.resume(returning: retValue)
                } else {
                    print("2-")
                    continuation.resume(throwing: error as! Never)
                }
            }
        })
    }
}
