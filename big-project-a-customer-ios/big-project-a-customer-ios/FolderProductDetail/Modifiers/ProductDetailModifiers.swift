//
//  ProductDetailImageModifier.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2022/12/27.
//

import SwiftUI

extension Image {
    // MARK: 제품 상세 페이지의 제품 썸네일 이미지에 대한 Modifier
    func productImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
    }
    
    // MARK: 제품 상세 페이지의 제품 상세 정보 이미지에 대한 Modifier
    func productDetailImageModifier(height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
    }
}

// MARK: 제품 상세 페이지의 제품 이름에 대한 Modifier
struct ProductTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 4)
            .padding(.top, 6)
    }
}

// MARK: 제품 상세 페이지의 버튼들에 대한 Modifier
struct ProductButtonModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}
