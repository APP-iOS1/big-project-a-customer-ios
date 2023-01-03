////
////  MyShoppingListCell.swift
////  big-project-a-customer-ios
////
////  Created by 기태욱 on 2023/01/03.
////
//
//import SwiftUI
//
//struct MyShoppingListCell: View {
//    var body: some View {
//        
//        @Binding var item: String
//        @Binding var checked: Bool
//        @Binding var isShowingShoppinglist: Bool
//        @Binding var selectItem: (image: String, name: String)?
//        
//        var body: some View{
//            
//            VStack{
//                
//                Text(checked ? "주문일: 2022.12.22" : "")
//                
//                HStack{
//                    
//                    Image(systemName: checked ? "checkmark.square.fill" : "square")
//                        .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
//                        .onTapGesture {
//                            self.checked.toggle()
//                            selectItem = (image: "itemImage", name: "ipTIME 외장케이스 WHITE HDD 3135 Plus")
//                        }
//                    
//                    
//                    Image("itemImage")
//                        .ImageResizeModifier()
//                    
//                    
//                    VStack{
//                        Text("ipTIME 외장케이스 WHITE HDD 3135 Plus")
//                            .bold()
//                        
//                        HStack{
//                            Text("29400원")
//                                .font(.caption)
//                            Spacer()
//                            Text("1개")
//                                .font(.caption)
//                        }
//                        .foregroundColor(.gray)
//                        
//                    }
//                    
//                    
//                }
//                .frame(width: 350, height: 100)
//                .padding(10)
//                
//                
//                //Divider()
//                
//                
//                
//                
//            }
//        }
//    }
//}
//
//struct MyShoppingListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MyShoppingListCell()
//    }
//}
