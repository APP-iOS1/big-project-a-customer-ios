//
//  ProductDetailView.swift
//  ProductDetail
//
//  Created by 박희경 on 2022/12/27.
//

import SwiftUI

struct ProductDetailView: View {

    @State private var imageWidth: CGFloat = UIScreen.main.bounds.width
    @State private var imageHeight: CGFloat = 200
    @State private var options: [String: [String]] = [
        "사이즈": ["S_0", "M_0", "L_0"],
        "컬러": ["레드_1000", "블루_2000", "블랙_3000"]
    ]
    //하트이미지
    var heartImage: Image {
        isLike ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }

    @State var isLike = false
    @State private var isShow = false
    @EnvironmentObject var myReviewViewModel: MyReviewViewModel

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

                        Divider()
                        // TODO: - 문의 Section
                        // TODO: - 리뷰 Section
                        NavigationLink(destination: QnAListView()) {
                            HStack {
                                Text("상품 문의")

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                            .buttonStyle(.automatic)
                            .foregroundColor(.black)
                            .padding()

                        Divider()

                        NavigationLink(destination: ProductDetailTotalReview()) {
                            HStack {
                                Text("리뷰 확인")

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
//                            ProductDetailReviewSection()
                        }
                            .buttonStyle(.automatic)
                            .foregroundColor(.black)
                            .padding()

//                        Divider()

                        Image("productInformation")
                            .resizable()
                            .scaledToFit()

                        Image("productDetail")
                            .resizable()
                            .scaledToFit()
//                            .scaledToFill()
//                            .frame(width: geo.size.width, height: imageHeight)
//                            .clipped()
//                            .scaledToFit()

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

                    }
                }//scroll vstack

                HStack {
                    Button {
                        print("")
                        isLike.toggle()
                    } label: {
                        HStack {
                            heartImage
                                .foregroundColor(.red)
                        }
                            .modifier(ProductButtonModifier(color: .white))
                    }
                    Button {
                        self.isShow = true
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

            // TODO: - navibar (safe area)
            .toolbar {
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    Button(action: { }) {
                //                        Image(systemName: "magnifyingglass")
                //                    }
                //                        .foregroundColor(.black)
                //                }
            }

//            .navigationBarHidden(false)
        }
            .sheet(isPresented: $isShow) {
            ProductDetailModalView(options: $options)
                .presentationDetents([.medium, .large])
        }
        // navigationView
    }

}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView().environmentObject(MyReviewViewModel())
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let produectImageHeight: CGFloat = 270.0
}
