//
//  ProductDetailReviewSection.swift
//  big-project-a-customer-ios
//
//  Created by 박제균 on 2023/01/02.
//

import SwiftUI

struct ProductDetailReviewSection: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("상품평")
                    .font(.title2)
                Spacer()
                // TODO: - 네비게이션 링크: 전체리뷰
                Image(systemName: "chevron.right")
            }
                .padding()

            Divider()

            HStack {
                ForEach(0..<5) { i in
                    Image(systemName: "star.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 15, height: 13)
                }

                // TODO: - 총 리뷰 수 연결
                Text("1017")
                    .font(.title3)

                Spacer()
            }
                .padding()

            Divider()

            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {

                Image("iphone14pro1")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("iphone14pro2")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("macbookair1")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("macbookair2")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("macbookair3")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("macbookpro1")
                    .resizable()
                    .frame(width: 75, height: 75)

                Image("macbookpro2")
                    .resizable()
                    .frame(width: 75, height: 75)
            }
                .frame(maxHeight: 180)
            
            Divider()
            
        }
    }
}

struct ProductDetailReviewSection_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailReviewSection()
    }
}
