//
//  ProductDetailView.swift
//  ProductDetail
//
//  Created by 박희경 on 2022/12/27.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State private var imageHeight: CGFloat = 0
    @State private var options: [String: [String]] = ["사이즈" : ["S", "M", "L"]]
    
    
    var body: some View {
        // FIXME: - 외부에서 NavigationStack으로 감싸주기
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        TabView {
                            ForEach(1..<5) { i in
                                Image("applewatch\(i)")
                                    .productImageModifier()
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: UIScreen.screenWidth)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Apple 애플워치 시리즈 8")
                                .modifier(ProductTitleModifier())
                            
                            HStack {
                                Image(systemName: "star")
                                    .renderingMode(.original)
                                
                                Text("4.7")
                                    .padding(.trailing, 10)
                                
                                Text("리뷰 100건 구매 4,681건")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }.padding(.bottom, 10)
                            
                            Text("596,730원")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.leading, 15)
                        
                        Image("productInformation")
                            .resizable()
                            .scaledToFit()
       
                        Button {
                            // 버튼을 눌렀을때 image의 height를 최대로 늘려준다.
                            imageHeight = CGFloat.infinity
                        } label: {
                            HStack {
                                Spacer()
                                Text("상품정보 더보기")
                                Spacer()
                            }
                        }
                        
                        Image("productDetail")
                            .productDetailImageModifier(height: imageHeight)
                    }
                }//scroll vstack
                
                HStack {
                    Button {
                        print("")
                    } label: {
                        HStack {
                            Image(systemName: "heart")
                                .renderingMode(.original)
                        }
                        .modifier(ProductButtonModifier(color: .white))
                    }
                    
                    Button {
                        print("")
                    } label: {
                        HStack {
                            Spacer()
                            Text("구매하기")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .modifier(ProductButtonModifier(color: .pink))
                    }
                    .tint(.white)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(.black)
                }
                
            }
        }
        // navigationView
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let produectImageHeight: CGFloat = 270.0
}
