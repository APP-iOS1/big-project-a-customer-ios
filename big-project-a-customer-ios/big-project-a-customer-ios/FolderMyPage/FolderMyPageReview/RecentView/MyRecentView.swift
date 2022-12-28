//
//  MyRecentView.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

// MARK: - 최근 본 상품 데이터 모델 (목업)
// FIXME: 데이터 변경 필요함!
struct RecentViewedItems: Identifiable {
    var id = UUID().uuidString
    var itemName: String
    var itemPrice: Int
    var image: String
}

// MARK: - 최근 본 상품 뷰 모델
// FIXME: 데이터 변경 필요함!
/// 최근 본 상품  item들을 가지고 있음
class RecentViewedViewModel: ObservableObject {
    @Published var recentViewedItems: [RecentViewedItems] = [
        RecentViewedItems(itemName: "MacBook Pro", itemPrice: 2060000, image: "macbookpro"),
        RecentViewedItems(itemName: "MacBook Air", itemPrice: 1690000, image: "macbookair"),
        RecentViewedItems(itemName: "Iphone 14", itemPrice: 1550000, image: "iphone14")
    ]
}

struct MyRecentView: View {
    @ObservedObject var recentViewedViewModel: RecentViewedViewModel = RecentViewedViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            ForEach($recentViewedViewModel.recentViewedItems) { item in
                RecentDetailView(item: item, vm: recentViewedViewModel)
                .padding(.vertical)
                
                Divider()
            }
        })
        .navigationTitle("최근 본 상품")
    }
}

struct MyRecentView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecentView()
    }
}
