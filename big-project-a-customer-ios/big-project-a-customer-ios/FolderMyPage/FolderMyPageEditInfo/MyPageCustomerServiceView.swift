//
//  MyPageCustomerService.swift
//  big-project-a-customer-ios
//
//  Created by greenthings on 2022/12/28.
//

import SwiftUI

struct MyPageCustomerServiceView: View {
    
    @State var somethingToAsk = "문의사항을 적어주세요."
    var placeholderString = "문의사항을 적어주세요."
    
    @State var myShoppingList = ["iPTime 외장 케이스"]
    
    @State var isShowingShoppinglist = false
    
    
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
                
                Text("주문 상품 문의")
                
                Button {
                    print("")
                    isShowingShoppinglist.toggle()
                } label: {
                    Text("주문상품 선택")
                }
                .sheet(isPresented: $isShowingShoppinglist) {
                    MyPageShoppingListView(isShowingShoppinglist: $isShowingShoppinglist, myShoppingList: $myShoppingList)
                }

                
                
            }
            
            TextEditor(text: $somethingToAsk)
                .scrollContentBackground(.hidden)
                .frame(width: 300,height: 300)
                .foregroundColor(self.somethingToAsk == placeholderString ? .gray : .primary)
                .onTapGesture {
                    if self.somethingToAsk == placeholderString {
                        self.somethingToAsk = ""
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(Color.secondary.opacity(0.5) ,lineWidth: 2)
                )
            
            
            HStack{
                
                Button {
                    print("Cancel")
                } label: {
                    Text("취소")
                      
                }
                
                Button {
                    print("Check")
                } label: {
                    Text("확인")
                      
                }
                
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

