//
//  SignUpViewModel.swift
//  big-project-a-customer-ios
//
//  Created by 박민주 on 2022/12/27.
//

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
    
    @MainActor
    func register(email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        do  {
            try await Auth.auth().createUser(withEmail: email, password: password)
            print("account created.")
            errorMessage = ""
            authenticationState = .authenticated
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }

}
