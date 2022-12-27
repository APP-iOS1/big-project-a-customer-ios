//
//  MyRecentView.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct MyRecentView: View {
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            RecentDetailView()
            RecentDetailView()
            RecentDetailView()
            RecentDetailView()
        })
        .navigationTitle("최근 본 상품")
    }
}

struct MyRecentView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecentView()
    }
}
