//
//  ProductDetailView.swift
//  ProductDetail
//
//  Created by 박희경 on 2022/12/27.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var myReviewViewModel: MyReviewViewModel
    @ObservedObject var tempVM: TempViewModel = TempViewModel()
    
    @State var isLike = false
    @State private var isShow = false
    @State private var isActive = false
    
    var body: some View {
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
                    
                    QnAAndReviewNavigationButton()
                    
                    Divider()
                    
                    // 상품 상세 정보 이미지
                    Image("productInformation")
                        .resizable()
                        .scaledToFit()
                    
                    Image("productDetail")
                        .resizable()
                        .scaledToFit()
                }
            }//scroll vstack
            
            // Modal에서 구매하기 버튼을 눌렀을때 productDetailView에서 OrderSheetAddress로 이동하기 위한 링크
            NavigationLink(isActive:$isActive) {
                // 임시 뷰모델의 totalPrice
                OrderSheetAddress(totalPriceForBinding: $tempVM.totalPrice)
            } label: { }
            
            FavoriteAndPurchaseButton(isLike: $isLike, isShow: $isShow)
        }
        .sheet(isPresented: $isShow) {
            ProductDetailModalView(isActive: $isActive)
                .presentationDetents([.height(400), .large])
        }
        // navigationView
    }
}

// MARK: - QnA, 리뷰 뷰로 이동하는 네비게이션 버튼
struct QnAAndReviewNavigationButton: View {
    var body: some View {
        VStack {
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
            }
            .buttonStyle(.automatic)
            .foregroundColor(.black)
            .padding()
        }
    }
}

// MARK: - 좋아요, 구매하기 버튼
struct FavoriteAndPurchaseButton: View {
    @Binding var isLike: Bool
    @Binding var isShow: Bool
    
    var body: some View {
        HStack {
            Button {
                isLike.toggle()
            } label: {
                HStack {
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 22, height: 22)
                }
                .modifier(ColoredButtonModifier(cornerRadius: 10))
            }
            Button {
                isShow = true
            } label: {
                HStack {
                    Spacer()
                    Text("구매하기")
                        .fontWeight(.bold)
                        //.frame(height: 24)
                    Spacer()
                }
                .modifier(ColoredButtonModifier(cornerRadius: 10))
            }
        }
        .padding(4)
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
}
