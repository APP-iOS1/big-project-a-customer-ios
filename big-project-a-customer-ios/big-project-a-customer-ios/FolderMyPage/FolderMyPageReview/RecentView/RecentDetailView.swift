//
//  RecentDetailView.swift
//  big-project-a-customer-ios
//
//  Created by 김태성 on 2022/12/27.
//

import SwiftUI

struct RecentDetailView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("상품명")
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Text("카테고리")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.gray)
                            }

                        }
                        
                        HStack(alignment: .bottom) {
                            Text("602,360")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("원")
                                .font(.footnote)
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "cart")
                                    .foregroundColor(.black)
                                    
                            }
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
                .padding(10)
            }
            
            Rectangle()
                .frame(width: 400)
                .foregroundColor(.gray)
                .opacity(0.20)
        }
    }
}

struct RecentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecentDetailView()
    }
}
