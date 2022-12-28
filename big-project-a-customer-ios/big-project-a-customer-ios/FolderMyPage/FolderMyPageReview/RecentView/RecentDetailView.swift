//
//  RecentDetailView.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct RecentDetailView: View {
    @Binding var item: RecentViewedItems
    @ObservedObject var vm: RecentViewedViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.itemName)
                                    .font(.title3)

                                
                                Text(item.itemCategory)
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                                                        
                            Button {
                                let index = vm.recentViewedItems.firstIndex {
                                    $0.id == item.id
                                }

                                vm.recentViewedItems.remove(at: index!)
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.gray)
                            }

                        }
                        
                        HStack(alignment: .bottom) {
                            Text("\(item.itemPrice)")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("원")
                                .font(.footnote)
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "cart")
                                    .foregroundColor(.black)
                                    
                            }
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
                .padding(10)
            }
            
//            Rectangle()
//                .frame(width: 400)
//                .foregroundColor(.gray)
//                .opacity(0.20)
        }
    }
}

struct RecentDetailView_Previews: PreviewProvider {
    @State static var items = RecentViewedItems(itemName: "MacBook Pro", itemPrice: 2060000, itemCategory: "노트북", image: "macbookpro")
    @StateObject static var vm = RecentViewedViewModel()
    
    static var previews: some View {
        RecentDetailView(item: $items, vm: vm)
    }
}
