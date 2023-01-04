//
//  big_project_a_customer_iosApp.swift
//  big-project-a-customer-ios
//
//  Created by 지정훈 on 2022/12/27.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct big_project_a_customer_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MyReviewViewModel())
                .environmentObject(SignUpViewModel())
                .environmentObject(CategoryFilteredItemViewModel())
        }
    }
}
