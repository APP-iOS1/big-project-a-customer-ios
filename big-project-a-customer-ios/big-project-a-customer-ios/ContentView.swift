//
//  ContentView.swift
//  big-project-a-customer-ios
//
//  Created by 지정훈 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    @State private var options: [String: [String]] = [
        "사이즈": ["S_0", "M_0", "L_0"],
        "컬러": ["레드_2000", "블루_3000", "블랙_1000"]
    ]
    var body: some View {
        TabView {
            ProductDetailModalView(options: $options).tabItem {
                Image(systemName: "house")
                Text("홈")
            }.tag(1)
            MyPageInfoView().tabItem {
                Image(systemName: "person.circle")
                Text("마이페이지")
            }.tag(2)
            ShoppingBackView().tabItem {
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
