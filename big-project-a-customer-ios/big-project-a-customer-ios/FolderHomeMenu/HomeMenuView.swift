//
//  HomeMenuView.swift
//
//  Created by 이원형 on 2022/12/27.
import SwiftUI

// MARK: Cell별 카테고리를 관리하기 위한 구조체
struct Item: Identifiable{
    let id = UUID()
    let categoryTitles: String
    let categoryImages: String
}

var items = [
    Item(categoryTitles: "노트북", categoryImages: "Notebook"),
    Item(categoryTitles: "휴대폰", categoryImages: "Phone"),
    Item(categoryTitles: "PC", categoryImages: "Desktop"),
    Item(categoryTitles: "모니터", categoryImages: "Monitor"),
    Item(categoryTitles: "태블릿", categoryImages: "Tablet"),
    Item(categoryTitles: "스마트워치", categoryImages: "Watch"),
    
]


struct HomeMenuView: View {
    @State var searchItem = items
    @State private var searchText = ""
    
    let columns = [
        GridItem(.fixed(170)),
        GridItem(.fixed(170))
    ]
    
    var body: some View{
        NavigationStack {
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(searchItem) { item in
                        NavigationLink {
                            NotebookView()
                        } label:{
                            ItemView(item: item)
                        }
                    }//ForEach
                }//LazyVGrid
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .onChange(of: searchText) { index in
                    if !index.isEmpty{
                        searchItem = items.filter { $0.categoryTitles.contains(index) }
                    } else {
                        searchItem = items
                    }
                }//.onChange
            }//ScrollView
            .navigationTitle("쇼핑하기")
        }//NavigationStack
      
        .background(.white)
    }
    // MARK: 홈 메뉴에 그려질 Cell View
    struct ItemView: View{
        let item: Item
        var body: some View{
            
            VStack(spacing: 0){
                Text(item.categoryTitles)
                    .font(.system(.title3 , weight: .bold))
                    .foregroundColor(Color.black.opacity(0.8))
                
                Image(item.categoryImages)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:85, height: 85)
            }
            .modifier(CategoryButtonModifier(color: .white))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuView()
    }
}
