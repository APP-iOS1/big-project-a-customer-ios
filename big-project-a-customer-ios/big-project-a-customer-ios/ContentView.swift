//
//  ContentView.swift
//  big-project-a-customer-ios
//
//  Created by 지정훈 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("뷰가 들어갈 자리1").tabItem {
                Image(systemName: "house")
                Text("홈")
            }.tag(1)
            Text("뷰가 들어갈 자리2").tabItem {
                Image(systemName: "person.circle")
                Text("마이페이지")
            }.tag(2)
            Text("뷰가 들어갈 자리3").tabItem {
                Image(systemName: "cart.badge.plus")
                Text("장바구니")
            }.tag(3)
            Text("뷰가 들어갈 자리4").tabItem {
                Image(systemName: "shippingbox.and.arrow.backward")
                Text("배송관리")
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
