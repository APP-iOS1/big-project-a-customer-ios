//
//  MyPageCustomerService.swift
//  big-project-a-customer-ios
//
//  Created by greenthings on 2022/12/28.
//

import SwiftUI

struct MyPageCustomerServiceView: View {
    @Environment(\.dismiss) private var dismiss

    
    @ObservedObject var customerServiceStore: CustomerServiceStore
    @EnvironmentObject var signupViewModel: SignUpViewModel

    @State var somethingToAsk = ""
    @State var somethingToAskTitle = ""
    
    var placeholderString = "문의사항을 적어주세요."
    
    @State var myShoppingList = ["iPTime 외장 케이스"]

    @State var isShowingShoppinglist = false
    @State var selectItem: (image: String, name: String)?
    
    @State var chooseItem : String
    @State var itemImage: [String]
    @State var itemName: String
    
    
    var body: some View {
        List {
            NavigationLink {
                customerservice
            } label: {
                Text("주문 상품 문의")
            }
            
            NavigationLink {
                MyQuestionReview()
            } label: {
                Text("작성한 문의 글")
            }
            
        }
        
        
    }
    
    var customerservice: some View {
        
        VStack{
            ScrollView{
                HStack{
                    Button {
                        print("")
                        isShowingShoppinglist.toggle()
                    } label: {
                        Text("주문상품 선택")
                    }
                    .sheet(isPresented: $isShowingShoppinglist) {
                        MyPageShoppingListView(isShowingShoppinglist: $isShowingShoppinglist, chooseItem: $chooseItem, itemImage: $itemImage, itemName: $itemName)
                    }
                }
                
                HStack{
                    Image("\(itemImage[0])")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("\(itemName)")
                        .font(.body)
                    
                }
                
                
                if let selectItem = selectItem {
                    HStack {
                        Image(selectItem.image)
                            .ImageResizeModifier()
                        
                        Text(selectItem.name)
                    }
                    .frame(width: 300)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color.secondary.opacity(0.5) ,lineWidth: 2)
                    )
                }
                VStack{
                    HStack{
                        Text("문의 제목")
                            .bold()
                            .padding(.leading, 20)
                        Spacer()
                    }
                    TextField("제목을 작성해주세요", text: $somethingToAskTitle, axis: .vertical)
                        .lineLimit(1...)
                        .textFieldStyle(.roundedBorder)
                        .padding(20)
                        .padding(.top, -25)
                    
                    HStack{
                        Text("문의 내용")
                            .bold()
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    TextField("문의 내용을 작성해주세요.", text: $somethingToAsk, axis: .vertical)
                        .lineLimit(12...)
                        .textFieldStyle(.roundedBorder)
                        .padding(20)
                        .padding(.top, -25)
                    
                    Text("주민번호, 전화번호, 이메일 등 개인정보를 남기면 타인에 의해 도용될 수 있습니다. 개인정보는 상품문의에 남기지 말아주세요.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                }
            }
            
            HStack{
                
                Button {
                    print("button pressed")
                    Task {
                        await customerServiceStore.createMyQuestionService(title:somethingToAskTitle, description:somethingToAsk ,itemImage: itemImage, itemName: itemName, orderId: chooseItem, userId: signupViewModel.currentUser?.id ?? "")
                    }
                    dismiss()

                } label: {
                    Text("리뷰 등록하기")
                }
                .modifier(MaxWidthColoredButtonModifier(cornerRadius: 10))
                .padding(.bottom, 20)
                .disabled((somethingToAsk.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && somethingToAskTitle.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && chooseItem.trimmingCharacters(in: .whitespacesAndNewlines).count != 0) ? false : true)
                
                Spacer()
            }
        }
        .navigationTitle("문의하기")
    }
}


//struct MyPageCustomerServiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            MyPageCustomerServiceView(customerServiceStore: customerServiceStore, chooseItem: "" )
//
//        }
//    }
//}
//
