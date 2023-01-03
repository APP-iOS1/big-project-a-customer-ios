//
//  MyPageShoppingListView.swift
//  big-project-a-customer-ios
//
//  Created by greenthings on 2022/12/28.
//

import SwiftUI

struct MyPageShoppingListView: View {
    
    @Binding var isShowingShoppinglist: Bool
    @Binding var myShoppingList: [String]
    @Binding var selectItem: (image: String, name: String)?
    @State var checked: Bool = false
    
    var body: some View {
        List{
            VStack{
                ForEach($myShoppingList, id: \.self) { item in
                    MyPageShoppingListRowView(item: item, checked: $checked, isShowingShoppinglist: $isShowingShoppinglist, selectItem: $selectItem)
                }
            }
        
        }
        .listStyle(.plain)
        
        VStack{
            if checked{
                Button {
                    print("확인")
                    isShowingShoppinglist.toggle()
                } label: {
                    Text("확인")
                        .frame(width:300, height: 100)
                }
                
            }
        }
    }

    
    
    struct MyPageShoppingListRowView: View{
        
        @Binding var item: String
        @Binding var checked: Bool
        @Binding var isShowingShoppinglist: Bool
        @Binding var selectItem: (image: String, name: String)?

        var body: some View{
            
            VStack{
                Text("주문일: 2022.12.22")
                HStack{
                    
                    Image(systemName: checked ? "checkmark.square.fill" : "square")
                        .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            self.checked.toggle()
                            selectItem = (image: "itemImage", name: "ipTIME 외장케이스 WHITE HDD 3135 Plus")
                        }
                    
                    
                    Image("itemImage")
                        .ImageResizeModifier()
                    
                    
                    VStack{
                        Text("ipTIME 외장케이스 WHITE HDD 3135 Plus")
                        Text("29400원")
                            .font(.caption)
                        Text("1개")
                            .font(.caption)
                    }
                    
                    
                }
                .frame(width: 350, height: 100)
                .padding(10)
                .border(.black)
                
            }
            
            
        }
    }
    
    struct MyPageShoppingListView_Previews: PreviewProvider {
        static var previews: some View {
            MyPageShoppingListView(isShowingShoppinglist: .constant(false), myShoppingList: .constant(["Mac"]), selectItem: .constant(nil))
        }
    }
    
}
