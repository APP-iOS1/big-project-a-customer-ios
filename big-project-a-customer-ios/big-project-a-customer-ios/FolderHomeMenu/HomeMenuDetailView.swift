//
//  HomeMenuDetailView.swift
//  big-project-a-customer-ios
//
//  Created by 이원형 on 2022/12/27.
//

import SwiftUI


struct FilteredItem: Hashable {
//    let id = UUID()
    var name: String
    var price: Double
}

struct HomeMenuDetailView: View {
    @EnvironmentObject private var itemInfoViewModel: ItemInfoViewModel
    
//    @State var searchNotebookItem = NotebookItems
    @State private var searchText = ""
    var items: Item
    let columns = [
           GridItem(.fixed(170)),
           GridItem(.fixed(170))
       ]
    
    var body: some View{
        NavigationStack {
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(itemInfoViewModel.filteredItem, id: \.self) { item in
                        NavigationLink {
                            ProductDetailView()
                        } label:{
                            ItemView(item: item, imageName: items.categoryImages)
                        }
                    }//ForEach
                }//LazyVGrid
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
//                .onChange(of: searchText) { index in
//                    if !index.isEmpty{
//                        searchNotebookItem = NotebookItems.filter { $0.NotebookTitles.localizedStandardContains(index) }
//                    } else {
//                        searchNotebookItem = NotebookItems
//                    }
//                }//.onChange
            }//ScrollView
            .navigationTitle("\(items.categoryTitles)")
        }//NavigationStack
      
        .background(.white)
        .onAppear {
            itemInfoViewModel.fliteringCategoryItems(items.categoryTitles)
        }
    }
    // MARK: 홈 메뉴에 그려질 Cell View
    struct ItemView: View{
        let item: ItemInfoViewModel.FilteredItem
        let imageName: String
        let formatter: NumberFormatter = {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                return formatter
            }()
        
        var body: some View{
            
            VStack(spacing: 0){

                // TODO: 이미지 어떻게 할지?? 일단 같은 카테고리 에셋 이미지로 넣어둠
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:85, height: 85)
                
                Text(item.name)
                    .font(.system(.body, weight: .thin))
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text("₩\(Int(item.price))")
                    .font(.system(.footnote , weight: .bold))
                    .foregroundColor(Color.blue.opacity(0.8))
            }
            .modifier(ContentButtonModifier(color: .white))
        }
    }
}
