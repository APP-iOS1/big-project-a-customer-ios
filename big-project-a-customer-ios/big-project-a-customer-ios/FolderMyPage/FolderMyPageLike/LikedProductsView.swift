//
//  LikedProductsView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//
import SwiftUI
// MARK: 좋아요한 전체 item 목록
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
                    VStack{
                        ItemListCell()
                        Divider()
                            .background(Color("AccentColor"))
                        
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("좋아요 한 상품")
    }
}

// MARK: 재사용 위한 item cell
struct ItemListCell: View {
    @State var price = 29400
    @State var itemName = "ipTIME 외장케이스 WHITE HDD 3135 Plus"
    @State var itemImage = "itemImage" // image
    @State var isLike = true
    var heartImage: Image {
        isLike ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }

    var body: some View{
        VStack(alignment: .leading){
            Image(itemImage)
                .ImageResizeModifier(width: 150, height: 150, cornerRadius: 20)
                .overlay(
                    Button(action: {
                        // MARK: 좋아요 정보 수정
                        isLike.toggle()
                    }, label: {
                        heartImage
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    })
                )

            Text("\(itemName)")
                .font(.footnote)
            Text("\(price)")
                .bold()
                .foregroundColor(.accentColor)
                .font(.callout)
        }
        .frame(maxWidth: UIScreen.main.bounds.width/2)
        .padding()
    }
}
struct LikedProductsView_Previews: PreviewProvider {
    static var previews: some View {
        LikedProductsView()
    }
}
