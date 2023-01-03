//
//  NotebookView.swift
//  big-project-a-customer-ios
//
//  Created by 이원형 on 2022/12/27.
//

import SwiftUI


struct NotebookItem: Identifiable{
    let id = UUID()
    let NotebookTitles: String
    let NotebookImages: String
    let NotebookPrices: String
}

var NotebookItems = [
    NotebookItem(NotebookTitles: "MacBookPro 14", NotebookImages: "Notebook", NotebookPrices: "₩2,690,000"),
    NotebookItem(NotebookTitles: "MacBookPro 13", NotebookImages: "Notebook", NotebookPrices: "₩2,490,000"),
    NotebookItem(NotebookTitles: "MacBookPro 16", NotebookImages: "Notebook", NotebookPrices: "₩3,090,000"),
    NotebookItem(NotebookTitles: "MacBookAir 13", NotebookImages: "Notebook", NotebookPrices: "₩1,690,000"),
    NotebookItem(NotebookTitles: "MacBookAir 13", NotebookImages: "Notebook", NotebookPrices: "₩1,690,000"),
    NotebookItem(NotebookTitles: "MacBookPro 14", NotebookImages: "Notebook", NotebookPrices: "₩2,690,000"),
    NotebookItem(NotebookTitles: "MacBookPro 16", NotebookImages: "Notebook", NotebookPrices: "₩3,790,000"),
    NotebookItem(NotebookTitles: "MacBookPro 16", NotebookImages: "Notebook", NotebookPrices: "₩3,090,000"),
]

struct NotebookView: View {
    @State var searchNotebookItem = NotebookItems
    @State private var searchText = ""
    
    let columns = [
           GridItem(.fixed(170)),
           GridItem(.fixed(170))
       ]
       
    
    var body: some View{
        NavigationStack {
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(searchNotebookItem) { item in
                        NavigationLink {
                            ProductDetailView()
                        } label:{
                            ItemView(item: item)
                        }
                    }//ForEach
                }//LazyVGrid
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .onChange(of: searchText) { index in
                    if !index.isEmpty{
                        searchNotebookItem = NotebookItems.filter { $0.NotebookTitles.localizedStandardContains(index) }
                    } else {
                        searchNotebookItem = NotebookItems
                    }
                }//.onChange
            }//ScrollView
            .navigationTitle("노트북")
        }//NavigationStack
      
        .background(.white)
    }
    // MARK: 홈 메뉴에 그려질 Cell View
    struct ItemView: View{
        let item: NotebookItem
        var body: some View{
            
            VStack(spacing: 0){

                Image(item.NotebookImages)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:85, height: 85)
                
                Text(item.NotebookTitles)
                    .font(.system(.body, weight: .thin))
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text(item.NotebookPrices)
                    .font(.system(.footnote , weight: .bold))
                    .foregroundColor(Color.blue.opacity(0.8))
            }
            .modifier(ContentButtonModifier(color: .white))
        }
    }
}
