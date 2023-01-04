//
//  MyPageCustomerService.swift
//  big-project-a-customer-ios
//
//  Created by greenthings on 2022/12/28.
//

import SwiftUI

struct MyPageCustomerServiceView: View {
    
    @State var somethingToAsk = ""
    var placeholderString = "문의사항을 적어주세요."
    
    @State var myShoppingList = ["iPTime 외장 케이스"]
    
    @State var isShowingShoppinglist = false
    @State var selectItem: (image: String, name: String)?
    
    
    
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
            
            HStack{
                
                
                
                Button {
                    print("")
                    isShowingShoppinglist.toggle()
                } label: {
                    Text("주문상품 선택")
                }
                .sheet(isPresented: $isShowingShoppinglist) {
                    //                    MyPageShoppingListView(isShowingShoppinglist: $isShowingShoppinglist, myShoppingList: $myShoppingList, selectItem: $selectItem)
                    MyPageShoppingListView(isShowingShoppinglist: $isShowingShoppinglist)
                }
                
                
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
            
            //TextEditor(text: $somethingToAsk)
            //                .scrollContentBackground(.hidden)
            //                .frame(width: 300,height: 300)
            //                .foregroundColor(self.somethingToAsk == placeholderString ? .gray : .primary)
            //                .onTapGesture {
            //                    if self.somethingToAsk == placeholderString {
            //                        self.somethingToAsk = ""
            //                    }
            //                }
            //                .padding()
            //                .overlay(
            //                    RoundedRectangle(cornerRadius: 20).stroke(Color.secondary.opacity(0.5) ,lineWidth: 2)
            //                )
            TextField("문의 내용을 작성해주세요.", text: $somethingToAsk, axis: .vertical)
                .lineLimit(15...)
                .textFieldStyle(.roundedBorder)
                .padding(20)
                .padding(.top, -25)
            
            HStack{
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width - 40)
                // TODO: 고치기
//                    .modifier(LoginButtonModifier(label: "문의 남기기"))
                    
            }
        }
    }
}


struct MyPageCustomerServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageCustomerServiceView()
        }
    }
}

