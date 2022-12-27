//
//  DurationSettingView.swift
//  Review
//
//  Created by 기태욱 on 2022/12/27.
//

import SwiftUI

struct DurationSettingView: View {
    @State var startDate = Date()
    @State var endDate = Date()

    @State private var isOnOneYear = false
    @State private var isOnOneWeek = false
    @State private var isOnOneMonth = false
    @State private var isOnThreeMonth = false
    @State private var isOnSixMonth = false
    
    @Binding var isShowingDuration : Bool
    
    func addOrSubtractMonth(month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: Date())!
    }
    
    func addOrSubtractDay(day: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: day, to: Date())!
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .center){
                
                HStack {
                    
                    
                    Button {
                        isOnOneYear.toggle()
                        isOnOneWeek = false
                        isOnOneMonth = false
                        isOnThreeMonth = false
                        isOnSixMonth = false
                        startDate = addOrSubtractMonth(month: -12)
                        
                    } label: {
                        Text("최근 1년")
                    }
                    .modifier(ButtonStyle(isColor: isOnOneYear))
                    
                    Button {
                        isOnOneYear = false
                        isOnOneWeek.toggle()
                        isOnOneMonth = false
                        isOnThreeMonth = false
                        isOnSixMonth = false
                        
                        startDate = addOrSubtractDay(day: -7)
                        
                    } label: {
                        Text("1주일")
                    }
                    .modifier(ButtonStyle(isColor: isOnOneWeek))
                    
                    Button {
                        isOnOneMonth.toggle()
                        isOnOneYear = false
                        isOnOneWeek = false
                        isOnThreeMonth = false
                        isOnSixMonth = false
                        
                        startDate = addOrSubtractMonth(month: -1)
                        
                    } label: {
                        Text("1개월")
                    }
                    .modifier(ButtonStyle(isColor: isOnOneMonth))
                    
                    Button {
                        isOnThreeMonth.toggle()
                        isOnOneYear = false
                        isOnOneWeek = false
                        isOnOneMonth = false
                        isOnSixMonth = false
                        
                        startDate = addOrSubtractMonth(month: -3)
                        
                    } label: {
                        Text("3개월")
                    }
                    .modifier(ButtonStyle(isColor: isOnThreeMonth))
                    
                    Button {
                        isOnSixMonth.toggle()
                        isOnOneYear = false
                        isOnOneWeek = false
                        isOnOneMonth = false
                        isOnThreeMonth = false
                        
                        startDate = addOrSubtractMonth(month: -6)
                        
                    } label: {
                        Text("6개월")
                    }
                    .modifier(ButtonStyle(isColor: isOnSixMonth))
                    
                }
                
                HStack{
                    DatePicker(
                        "",
                        selection: $startDate,
                        displayedComponents: [.date]
                        
                    )
                    .labelsHidden()
                    
                    Spacer()
                    Text("-")
                    Spacer()
                    
                    
                    
                    DatePicker(
                        "",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                }
                .padding(.top, 10)
                .padding(.trailing, 15)
                .padding(.leading, 15)
                
                HStack{
                    Spacer()
                    Button{
                        isOnOneYear = false
                        isOnOneWeek = false
                        isOnOneMonth = false
                        isOnThreeMonth = false
                        isOnSixMonth = false
                        
                        startDate = Date()
                        endDate = Date()
                    } label: {
                        Label("초기화", systemImage: "arrow.clockwise")
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button{
                        isShowingDuration.toggle()
                    } label: {
                        Text("적용하기")
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 15)
            }
            .background(Color.white)

            
            Rectangle()
                .opacity(0.6)
            
        }
    }
}

struct ButtonStyle : ViewModifier {
    
    var isColor : Bool
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(isColor ? Color.blue : Color(UIColor.lightGray))
            .cornerRadius(2.5)
    }
}


struct DurationSettingView_Previews: PreviewProvider {

    static var previews: some View {
        DurationSettingView(isShowingDuration:.constant(false))
    }
}
