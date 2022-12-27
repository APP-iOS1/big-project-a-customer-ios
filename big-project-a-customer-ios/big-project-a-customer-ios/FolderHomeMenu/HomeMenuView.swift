//
//  HomeView.swift
//  ProjectA-HomeMenu
//
//  Created by 이원형 on 2022/12/27.
//

import SwiftUI

struct Item: Identifiable{
    let id = UUID()
    let categoryTitles: String
    let categoryImages: String
    
}
struct HomeMenuView: View {
    @State private var searchText = ""
    let items = [
        Item(categoryTitles: "노트북", categoryImages: "Notebook"),
        Item(categoryTitles: "휴대폰", categoryImages: "Phone"),
        Item(categoryTitles: "PC", categoryImages: "Desktop"),
        Item(categoryTitles: "모니터", categoryImages: "Monitor"),
        Item(categoryTitles: "태블릿", categoryImages: "Tablet"),
        Item(categoryTitles: "스마트워치", categoryImages: "Watch"),
        ]
   
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        
        
        NavigationStack {
            VStack{
            }
            .searchable(text: $searchText)
            .padding(.top,30)
            ScrollView{
                LazyVGrid(columns: columns, spacing: 15){
                    ForEach(items) { item in
                            NavigationLink {
                                NotebookView()
                            } label:{
                            
                        
                            ItemView(item: item)
                        }
                    }
                    }
                .padding(10)
                }
            .background(.white)
            }
        }
    struct ItemView: View{
        let item: Item
        var body: some View{
          
                VStack(spacing: 0){
                    Text(item.categoryTitles)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.8))
                    
                    Image(item.categoryImages)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:85, height: 85)
                }
                .frame(width:160 , height: 160)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, y: 10)
            }
         
            
            
       
    }
    }


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
