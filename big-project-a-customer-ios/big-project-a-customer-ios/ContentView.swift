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
            HomeMenuView().tabItem {
                Image(systemName: "house")
                Text("홈")
            }.tag(1)
            PurchaseHistoryView().tabItem {
                Image(systemName: "shippingbox.and.arrow.backward")
                Text("주문내역")
            }.tag(2)
            ShoppingBackView().tabItem {
                Image(systemName: "cart.badge.plus")
                Text("장바구니")
            }.tag(3)
            MyPageInfoView().tabItem {
                Image(systemName: "person.circle")
                Text("마이페이지")
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

