//
//  PurchaseHistoryView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//

import SwiftUI
import PopupView

enum DeliveryStatusEnum: String {
    //    배송중
    //    배송완료
    //    배송준비중
    //    리뷰작성 가능
    //    리뷰작성 완료
    case pending
    case deliveryCompleted
    case createReview
}

struct OrderInfo: Identifiable {
    var id = UUID().uuidString
    var orderDate: String
    var itemAmount: Int
    var price: Int
    var deliveryStatusText: String
    var itemName: String
    var itemImage: String
    var deliveryStatus: DeliveryStatusEnum = .pending
}

class OrderInfoViewModel: ObservableObject {
    // ShoppingCartItems 약자
    @Published var orders: [OrderInfo] = [
        OrderInfo(orderDate: "2022. 12. 27", itemAmount: 1, price: 24900, deliveryStatusText: "배송중", itemName: "유그린 메탈쉘 외장하드 케이스 C to USB3.0", itemImage: "itemImage"),
        OrderInfo(orderDate: "2022. 11. 30", itemAmount: 1, price: 24900, deliveryStatusText: "배송완료", itemName: "벨킨 부스트업 24W 듀얼 A타입 가정용 충전기 WCB002krWH, 화이트", itemImage: "itemImage", deliveryStatus: .deliveryCompleted),
        OrderInfo(orderDate: "2022. 11. 28", itemAmount: 1, price: 66400, deliveryStatusText: "배송완료", itemName: "벨킨 7in1 USB C타입 멀티 허브 AVC009btSGY, 그레이", itemImage: "itemImage", deliveryStatus: .createReview),
        OrderInfo(orderDate: "2022. 09. 30", itemAmount: 1, price: 34900, deliveryStatusText: "배송완료", itemName: "트리플블랙 RX 4in1 충전 스테이션, 블랙", itemImage: "itemImage", deliveryStatus: .deliveryCompleted),
        OrderInfo(orderDate: "2022. 09.30", itemAmount: 1, price: 20800, deliveryStatusText: "배송완료", itemName: "벨킨 부스트업 USB C to 라이트닝 아이폰 고속 충전케이블 CAA003bt1MBK, 1m, 블랙", itemImage: "itemImage", deliveryStatus: .deliveryCompleted)
    ]
}

// MARK: 전체 구매목록
struct PurchaseHistoryView: View {
    @ObservedObject var orderStore: OrderInfoViewModel = OrderInfoViewModel()
    @State private var searchItem = ""
    @State private var deliveryCompletedChecked = false
    
    @State var isShowingLoginSheet = false
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        NavigationStack {
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(text: $searchItem) {
                        Text("주문한 상품을 검색할 수 있어요!")
                    }
                }
                .padding(.horizontal, 10)
                .modifier(PurchaseHistoryButtonModifier())
                .padding(.horizontal, 10)
                
                ScrollView {
                    ForEach(Array(orderStore.orders.enumerated()), id: \.offset){ (index, order) in
                        VStack {
                            HStack {
                                Text(order.orderDate)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                                Button {
                                    // 주문 상세보기
                                } label: {
                                    Text("주문 상세보기")
                                    Image(systemName: "chevron.right")
                                }
                                
                            }
                            
                            PurchaseListCell(orderStore: orderStore, order: order, index: index, isDeliveryCompleted: $deliveryCompletedChecked)
                        }
                        .padding(10)
                    }
                }
                
            } // VStack
            .onAppear { // 로그인이 되어있지 않다면 바로 로그인 뷰를 시트로 띄우기 위해 isShowingLoginSheet를 true로 고정
                if signUpViewModel.currentUser?.userEmail == nil {
                    isShowingLoginSheet = true
                }
            }
            .fullScreenCover(isPresented: $isShowingLoginSheet) {
            LoginView()
        }
    } 
}

// MARK: 재사용하기 위한 구매목록 cell
struct PurchaseListCell: View {
    @ObservedObject var orderStore: OrderInfoViewModel
    var order: OrderInfo
    let index: Int
    @Binding var isDeliveryCompleted: Bool
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(order.deliveryStatusText)")
                    .font(.headline)
            }
            HStack(alignment: .top){
                Image(order.itemImage)
                    .ImageResizeModifier()
                VStack(spacing: 10){
                    Text("\(order.itemName)")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                    HStack{
                        Text("\(order.price)원")
                            .font(.caption)
                        Text("\(order.itemAmount)개")
                            .font(.caption)
                        Spacer()
//                        Button {
//                            // 장바구니로 이동
//                        } label: {
//                            Text("장바구니 담기")
//                                .font(.caption)
//                        }
//                        .modifier(PurchaseHistoryButtonModifier())
//                        .frame(maxWidth: 80)
                        
                    }
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            HStack{
                Button {
                    // 교환 반품 신청
                } label: {
                    Text("교환, 반품 신청")
                }
                .modifier(PurchaseHistoryButtonModifier())
                
                // TODO: - Delivery State에 따라서 버튼 바뀌어야 함 (배송조회/구매확정/리뷰작성)
                switch order.deliveryStatus {
                case .pending:
                    Button {
                        PurchaseHistoryDetailView()
                    } label: {
                        Text("배송조회")
                    }
                    .modifier(PurchaseHistoryButtonModifier(textColor: .accentColor, borderColor: .accentColor))
                case .deliveryCompleted:
                    Button {
                        orderStore.orders[index].deliveryStatus = .createReview
                        isDeliveryCompleted = true
                    } label: {
                        Text("구매확정")
                    }
                    .modifier(PurchaseHistoryButtonModifier(textColor: .accentColor, borderColor: .accentColor))
                    
                    
                case .createReview:
                    NavigationLink {
                        // 리뷰 작성 view
                        CreateReviewView()
                    } label: {
                        Text("리뷰작성")
                    }
                    .modifier(PurchaseHistoryButtonModifier(textColor: .accentColor, borderColor: .accentColor))                }
                
            }
            .font(.callout)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .modifier(PurchaseHistoryButtonModifier())
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseHistoryView()
    }
}
