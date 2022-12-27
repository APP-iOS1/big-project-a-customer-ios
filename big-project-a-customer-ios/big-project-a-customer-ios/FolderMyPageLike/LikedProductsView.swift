//
//  LikedProductsView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI

struct LikedProductsView: View {
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(0..<50) { index in
                    ItemListCell()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ItemListCell: View {
    @State var price = 29400
    @State var itemName = "ipTIME 외장케이스 WHITE HDD 3135 Plus"
    @State var itemImage = "itemImage" // image
    var body: some View{
        VStack(alignment: .leading){
            // TODO: 생각해보니까 여기는 메인페이지에서 코드 가져오면 됨 킥킥
            Image(itemImage)
                .resizable()
                .cornerRadius(20)
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fill)
            Text("\(itemName)")
                .font(.footnote)
            Text("\(price)")
                .bold()
                .foregroundColor(.accentColor)
                .font(.callout)
        }
        .frame(maxWidth: UIScreen.main.bounds.width/2 - 20)
        .padding()
    }
}

struct LikedProductsView_Previews: PreviewProvider {
    static var previews: some View {
        LikedProductsView()
    }
}
